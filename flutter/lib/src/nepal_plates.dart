import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'nepal_colors.dart';
import 'nepal_country.dart';

/// Where the ink sits.
///
/// Every photograph was flattened to a 500 × 248 "sheet" regardless of its own
/// shape (`.plateref/np/sheet_flat.png`) and its rows measured there; [flatHeight]
/// is that 248. The x numbers carry over unchanged (every plate is 500 wide);
/// a y is scaled by `canvasHeight / flatHeight` so a row keeps its place on the
/// plate's true shape. The true shapes are the article's physical sizes in mm,
/// not the photographs' aspect (the car rear photograph is a crop):
///
/// | plate         | mm        | canvas      |
/// |---------------|-----------|-------------|
/// | heavy front   | 520 × 110 | 500 × 105.8 |
/// | car front     | 450 × 110 | 500 × 122.2 |
/// | heavy rear    | 360 × 210 | 500 × 291.7 |
/// | car rear      | 300 × 185 | 500 × 308.3 |
/// | three-wheeler | 240 × 130 | 500 × 270.8 |
///
/// 1983–2019 plates are 500 × 248, the sheet itself: the article gives no
/// sizes for them and the heavy-vehicle and motorcycle photographs fit 2.02.
/// Light-vehicle photographs fit 1.82 and share the design.
///
/// Measured (brief rows, flat x/y): heavy front letters 183–294, digits
/// 302.8–458; car front class 100.2–142.8, letters+digits 184.5–466.5; heavy
/// rear flag 30–82, caption 202–319, class+letters 175.5–443.8 (y 45.2–131.5),
/// digits 174.8–443 (y 137–234.8); three-wheeler class 170.5–251, letters
/// 283.8–420, digits 186.2–417 (y 162.5–229.2), NEP 31.5–81 (y 139.5–161);
/// legacy rows y 18.8–88.8 and 115–239.8, digits x 91.2–420.2, diplomatic
/// rows y 22–135.5 and 181.2–235.2.
///
/// Read off the sheet by eye, not measured: where a measured blob holds two
/// fields (class | letters on the car rear, letters | digits on the car front,
/// zone | lot on the legacy plates) the split between them; the heavy rear's
/// class/letters split; caption and flag heights on the fronts and rear;
/// the diplomatic field boundaries. The car rear photograph is a close crop of
/// one glyph run, so it takes the heavy rear's layout.
abstract final class _Layout {
  static const double width = 500, flatHeight = 248;

  static const double heavyFrontHeight = 500 * 110 / 520;
  static const double carFrontHeight = 500 * 110 / 450;
  static const double heavyRearHeight = 500 * 210 / 360;
  static const double carRearHeight = 500 * 185 / 300;
  static const double threeWheelerHeight = 500 * 130 / 240;

  /// Front plates: caption over one serial row. Ink y on the sheet.
  static const double frontCaptionTop = 20, frontCaptionBottom = 54;
  static const double frontSerialTop = 86, frontSerialBottom = 233;
  static const double frontCaptionLeft = 150, frontCaptionRight = 350;

  static const _Fields heavyFront = _Fields(
    classLeft: 110.8,
    classRight: 146.2,
    seriesLeft: 183,
    seriesRight: 294,
    numberLeft: 302.8,
    numberRight: 458,
  );
  static const _Fields carFront = _Fields(
    classLeft: 100.2,
    classRight: 142.8,
    seriesLeft: 184.5,
    seriesRight: 278.5,
    numberLeft: 278.5,
    numberRight: 466.5,
  );

  /// Rear plates: caption, class and letters, then the number. Ink y.
  static const double rearCaptionLeft = 160, rearCaptionRight = 360;
  static const _RearRows rear = _RearRows(
    captionTop: 14,
    captionBottom: 34,
    classTop: 45.2,
    classBottom: 131.5,
    numberTop: 137,
    numberBottom: 234.8,
    fields: _Fields(
      classLeft: 175.5,
      classRight: 250,
      seriesLeft: 270,
      seriesRight: 443.8,
      numberLeft: 174.8,
      numberRight: 443,
    ),
  );
  static const _RearRows threeWheeler = _RearRows(
    captionTop: 18,
    captionBottom: 48,
    classTop: 62,
    classBottom: 131.2,
    numberTop: 162.5,
    numberBottom: 229.2,
    fields: _Fields(
      classLeft: 170.5,
      classRight: 251,
      seriesLeft: 283.8,
      seriesRight: 420.2,
      numberLeft: 186.2,
      numberRight: 417,
    ),
  );

  /// The flag strip on the rear plates: flag 30–82 wide, `NEP` under it at the
  /// three-wheeler's measured 139.5–161.
  static const double rearFlagLeft = 30, rearFlagWidth = 50, rearFlagTop = 74;
  static const double rearNepTop = 139.5, rearNepBottom = 161;

  /// The flag strip on the front plates, in canvas units.
  static const double carFrontFlagLeft = 22.5, carFrontFlagWidth = 37;
  static const double heavyFrontFlagLeft = 21, heavyFrontFlagWidth = 32;

  static const double flagAspect = 71.57 / 87.25;

  /// 1983–2019: canvas is the sheet. Ink y of the two rows.
  static const double legacyHeight = flatHeight;
  static const double legacyTopTop = 18.8, legacyTopBottom = 88.8;
  static const double legacyNumberTop = 115, legacyNumberBottom = 239.8;
  static const double legacyNumberLeft = 91.2, legacyNumberRight = 420.2;
  static const double legacyZoneLeft = 120, legacyZoneRight = 195;
  static const double legacyLotLeft = 195, legacyLotRight = 245;
  static const double legacyClassLeft = 262, legacyClassRight = 372;

  /// Diplomatic: Devanagari row over a Latin echo.
  static const double dipTop = 22, dipBottom = 135.5;
  static const double dipEchoTop = 181.2, dipEchoBottom = 235.2;
  static const double dipCountryLeft = 20.8, dipCountryRight = 140;
  static const double dipLabelLeft = 140, dipLabelRight = 385;
  static const double dipSerialLeft = 386, dipSerialRight = 499;
  static const double dipEchoCountryLeft = 74, dipEchoCountryRight = 150;
  static const double dipEchoLabelLeft = 165, dipEchoLabelRight = 315;
  static const double dipEchoSerialLeft = 325, dipEchoSerialRight = 414;
}

/// The x-spans of the class, series and number fields of a 2020-series plate.
class _Fields {
  const _Fields({
    required this.classLeft,
    required this.classRight,
    required this.seriesLeft,
    required this.seriesRight,
    required this.numberLeft,
    required this.numberRight,
  });

  final double classLeft, classRight;
  final double seriesLeft, seriesRight;
  final double numberLeft, numberRight;
}

class _RearRows {
  const _RearRows({
    required this.captionTop,
    required this.captionBottom,
    required this.classTop,
    required this.classBottom,
    required this.numberTop,
    required this.numberBottom,
    required this.fields,
  });

  final double captionTop, captionBottom;
  final double classTop, classBottom;
  final double numberTop, numberBottom;
  final _Fields fields;
}

/// A plate's canvas height, and the scale from sheet y to canvas y.
class _Canvas {
  const _Canvas(this.height);

  final double height;

  double y(double flat) => flat * height / _Layout.flatHeight;

  /// A field whose ink spans [inkTop]..[inkBottom] (sheet y) and
  /// [left]..[right] (x).
  ///
  /// Painted ink is about 55% of the box, so the box is the ink over 0.55,
  /// capped by what fits: no taller than the room above and below its centre
  /// (a box may not leave the canvas) and no wider than the run's characters
  /// take (`0.6 * 0.72` of the height each). A fixed run is spaced to its
  /// printed pitch.
  PlateSlot field(
    PlateAlphabet alphabet, {
    required double left,
    required double right,
    required double inkTop,
    required double inkBottom,
    int length = 1,
    int? minLength,
  }) {
    final double top = y(inkTop), bottom = y(inkBottom);
    final double cy = (top + bottom) / 2;
    final double box = min(
      min((bottom - top) / 0.55, 2 * min(cy, height - cy)),
      (right - left) / (length * 0.6 * 0.72),
    );
    final bool fixed = minLength == null || minLength == length;
    return PlateSlot(
      alphabet: alphabet,
      box: PlateBox(left, cy - box / 2, right - left, box),
      length: length,
      minLength: minLength,
      spacing: length > 1 && fixed
          ? plateRunSpacing((right - left) / length, box)
          : 0,
    );
  }

  /// A fixed label whose ink spans [inkTop]..[inkBottom] (sheet y).
  PlateLabel label(
    String text, {
    required double left,
    required double right,
    required double inkTop,
    required double inkBottom,
    Color? color,
  }) {
    final double top = y(inkTop), bottom = y(inkBottom);
    return PlateLabel(
      text: text,
      box: PlateBox.fromLTRB(left, top, right, bottom),
      glyphHeight: (bottom - top) / 0.55,
      color: color,
    );
  }
}

/// Nepal's plates: the 2020 series and the 1983–2019 series it replaced.
///
/// **2020 series** (Latin, black on white, a left strip with the flag and a
/// blue `NEP`): `BAGMATI B AB 0123`, a province, a class code, two series
/// letters and four digits. Two designs: *front* (caption above one serial row)
/// and *rear* (caption, class and letters, number on three rows), the rear in
/// three physical sizes. A field is one slot: the province is a picked name, the
/// class one or two characters (`C`, `C1`), the series two letters, the
/// number four digits. Pair every one with [NepalThemes.current].
///
/// **1983–2019 series** (Devanagari): zone code, a one or two digit lot, a
/// class letter and four digits, over two rows. One design serves private,
/// public, government, national corporation and tourist plates; the category is
/// the theme and the class letters the picker offers. The diplomatic plate has
/// its own: the country number, a fixed `सी.डी.` and a serial, echoed in Latin
/// below. Zone and class are picked from alphabets; the class letters are the
/// article's table, and the colours of each category come from the photographs.
///
/// Not implemented: the narrow one-line front plates of the 1983–2019 series
/// (their photographs are close crops that did not fit, and the national
/// corporation front was not fitted at all); sizes of the 1983–2019 plates.
/// The 1983–2019 numerals are stored as `0-9` and printed in Devanagari.
abstract final class NepalPlates {
  /// 2020 front plate of a heavy vehicle (520 × 110 mm).
  static final PlateSpec heavyFront = _front(
    'np.heavy_front',
    _Layout.heavyFrontHeight,
    _Layout.heavyFront,
    _Layout.heavyFrontFlagLeft,
    _Layout.heavyFrontFlagWidth,
  );

  /// 2020 front plate of a car (450 × 110 mm).
  static final PlateSpec carFront = _front(
    'np.car_front',
    _Layout.carFrontHeight,
    _Layout.carFront,
    _Layout.carFrontFlagLeft,
    _Layout.carFrontFlagWidth,
  );

  /// 2020 rear plate of a heavy vehicle (360 × 210 mm).
  static final PlateSpec heavyRear = _rear(
    'np.heavy_rear',
    _Layout.heavyRearHeight,
    _Layout.rear,
  );

  /// 2020 rear plate of a car (300 × 185 mm).
  static final PlateSpec carRear = _rear(
    'np.car_rear',
    _Layout.carRearHeight,
    _Layout.rear,
  );

  /// 2020 plate of a three-wheeler, front and rear (240 × 130 mm).
  static final PlateSpec threeWheeler = _rear(
    'np.three_wheeler',
    _Layout.threeWheelerHeight,
    _Layout.threeWheeler,
  );

  /// 1983–2019: zone, lot, class and four digits over two rows. The theme
  /// picks the category.
  static final PlateSpec legacy = _legacy();

  /// 1983–2019 diplomatic: `०१ सी.डी. २३` echoed in Latin.
  static final PlateSpec legacyDiplomatic = _legacyDiplomatic();

  static List<PlateSpec> get all => <PlateSpec>[
    heavyFront,
    carFront,
    heavyRear,
    carRear,
    threeWheeler,
    legacy,
    legacyDiplomatic,
  ];

  static const List<PlateTextGroup> _currentGroups = <PlateTextGroup>[
    PlateTextGroup(<int>[0], key: 'province'),
    PlateTextGroup(<int>[1], key: 'class'),
    PlateTextGroup(<int>[2], key: 'series'),
    PlateTextGroup(<int>[3], key: 'number'),
  ];

  static List<PlateSlot> _currentSlots(
    _Canvas c,
    _Fields f, {
    required double captionLeft,
    required double captionRight,
    required double captionTop,
    required double captionBottom,
    required double classTop,
    required double classBottom,
    required double numberTop,
    required double numberBottom,
  }) => <PlateSlot>[
    c.field(
      NepalAlphabets.province,
      left: captionLeft,
      right: captionRight,
      inkTop: captionTop,
      inkBottom: captionBottom,
    ),
    c.field(
      NepalAlphabets.vehicleClass,
      left: f.classLeft,
      right: f.classRight,
      inkTop: classTop,
      inkBottom: classBottom,
      length: 2,
      minLength: 1,
    ),
    c.field(
      NepalAlphabets.letters,
      left: f.seriesLeft,
      right: f.seriesRight,
      inkTop: classTop,
      inkBottom: classBottom,
      length: 2,
    ),
    c.field(
      NepalAlphabets.digits,
      left: f.numberLeft,
      right: f.numberRight,
      inkTop: numberTop,
      inkBottom: numberBottom,
      length: 4,
    ),
  ];

  static PlateSpec _front(
    String id,
    double height,
    _Fields f,
    double flagLeft,
    double flagWidth,
  ) {
    final _Canvas c = _Canvas(height);
    final double flagHeight = flagWidth / _Layout.flagAspect, flagTop = c.y(30);
    return PlateSpec(
      id: id,
      country: NepalCountry.nepal,
      canvasWidth: _Layout.width,
      canvasHeight: height,
      slots: _currentSlots(
        c,
        f,
        captionLeft: _Layout.frontCaptionLeft,
        captionRight: _Layout.frontCaptionRight,
        captionTop: _Layout.frontCaptionTop,
        captionBottom: _Layout.frontCaptionBottom,
        classTop: _Layout.frontSerialTop,
        classBottom: _Layout.frontSerialBottom,
        numberTop: _Layout.frontSerialTop,
        numberBottom: _Layout.frontSerialBottom,
      ),
      decals: <PlateDecal>[
        PlateDecal(
          drawing: NepalCountry.flagDrawing,
          box: PlateBox(flagLeft, flagTop, flagWidth, flagHeight),
        ),
      ],
      labels: <PlateLabel>[
        c.label(
          'NEP',
          left: flagLeft - 4,
          right: flagLeft + flagWidth + 4,
          inkTop: 138,
          inkBottom: 168,
          color: NepalColors.nepBlue,
        ),
      ],
      textGroups: _currentGroups,
    );
  }

  static PlateSpec _rear(String id, double height, _RearRows r) {
    final _Canvas c = _Canvas(height);
    return PlateSpec(
      id: id,
      country: NepalCountry.nepal,
      canvasWidth: _Layout.width,
      canvasHeight: height,
      slots: _currentSlots(
        c,
        r.fields,
        captionLeft: _Layout.rearCaptionLeft,
        captionRight: _Layout.rearCaptionRight,
        captionTop: r.captionTop,
        captionBottom: r.captionBottom,
        classTop: r.classTop,
        classBottom: r.classBottom,
        numberTop: r.numberTop,
        numberBottom: r.numberBottom,
      ),
      decals: <PlateDecal>[
        PlateDecal(
          drawing: NepalCountry.flagDrawing,
          box: PlateBox(
            _Layout.rearFlagLeft,
            c.y(_Layout.rearFlagTop),
            _Layout.rearFlagWidth,
            _Layout.rearFlagWidth / _Layout.flagAspect,
          ),
        ),
      ],
      labels: <PlateLabel>[
        c.label(
          'NEP',
          left: _Layout.rearFlagLeft - 4,
          right: _Layout.rearFlagLeft + _Layout.rearFlagWidth + 4,
          inkTop: _Layout.rearNepTop,
          inkBottom: _Layout.rearNepBottom,
          color: NepalColors.nepBlue,
        ),
      ],
      textGroups: _currentGroups,
    );
  }

  static PlateSpec _legacy() {
    const _Canvas c = _Canvas(_Layout.legacyHeight);
    return PlateSpec(
      id: 'np.legacy',
      country: NepalCountry.nepal,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.legacyHeight,
      slots: <PlateSlot>[
        c.field(
          NepalAlphabets.zone,
          left: _Layout.legacyZoneLeft,
          right: _Layout.legacyZoneRight,
          inkTop: _Layout.legacyTopTop,
          inkBottom: _Layout.legacyTopBottom,
        ),
        c.field(
          NepalAlphabets.devanagariDigits,
          left: _Layout.legacyLotLeft,
          right: _Layout.legacyLotRight,
          inkTop: _Layout.legacyTopTop,
          inkBottom: _Layout.legacyTopBottom,
          length: 2,
          minLength: 1,
        ),
        c.field(
          NepalAlphabets.legacyClass,
          left: _Layout.legacyClassLeft,
          right: _Layout.legacyClassRight,
          inkTop: _Layout.legacyTopTop,
          inkBottom: _Layout.legacyTopBottom,
        ),
        c.field(
          NepalAlphabets.devanagariDigits,
          left: _Layout.legacyNumberLeft,
          right: _Layout.legacyNumberRight,
          inkTop: _Layout.legacyNumberTop,
          inkBottom: _Layout.legacyNumberBottom,
          length: 4,
        ),
      ],
      textGroups: PlateTextGroup.perSlot(<String>[
        'zone',
        'lot',
        'class',
        'number',
      ]),
    );
  }

  static PlateSpec _legacyDiplomatic() {
    const _Canvas c = _Canvas(_Layout.legacyHeight);
    final double echoTop = c.y(_Layout.dipEchoTop);
    final double echoHeight = c.y(_Layout.dipEchoBottom) - echoTop;
    final double echoCy = echoTop + echoHeight / 2;
    // The echo's glyphs are taller than its box allows on the canvas; the
    // box stays inside, the glyph is the ink over 0.55.
    final double echoBox = 2 * (_Layout.legacyHeight - echoCy);
    final double echoGlyph = echoHeight / 0.55;
    PlateBox echo(double left, double right) =>
        PlateBox(left, echoCy - echoBox / 2, right - left, echoBox);
    return PlateSpec(
      id: 'np.legacy_diplomatic',
      country: NepalCountry.nepal,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.legacyHeight,
      slots: <PlateSlot>[
        c.field(
          NepalAlphabets.devanagariDigits,
          left: _Layout.dipCountryLeft,
          right: _Layout.dipCountryRight,
          inkTop: _Layout.dipTop,
          inkBottom: _Layout.dipBottom,
          length: 2,
          minLength: 1,
        ),
        c.field(
          NepalAlphabets.devanagariDigits,
          left: _Layout.dipSerialLeft,
          right: _Layout.dipSerialRight,
          inkTop: _Layout.dipTop,
          inkBottom: _Layout.dipBottom,
          length: 2,
          minLength: 1,
        ),
      ],
      labels: <PlateLabel>[
        c.label(
          'सी.डी.',
          left: _Layout.dipLabelLeft,
          right: _Layout.dipLabelRight,
          inkTop: _Layout.dipTop,
          inkBottom: _Layout.dipBottom,
        ),
        PlateLabel(
          text: 'C.D.',
          box: echo(_Layout.dipEchoLabelLeft, _Layout.dipEchoLabelRight),
          glyphHeight: echoGlyph,
        ),
      ],
      mirrors: <PlateMirror>[
        PlateMirror(
          source: 0,
          box: echo(_Layout.dipEchoCountryLeft, _Layout.dipEchoCountryRight),
          glyphHeight: echoGlyph,
          alphabet: NepalAlphabets.digits,
        ),
        PlateMirror(
          source: 1,
          box: echo(_Layout.dipEchoSerialLeft, _Layout.dipEchoSerialRight),
          glyphHeight: echoGlyph,
          alphabet: NepalAlphabets.digits,
        ),
      ],
      textGroups: PlateTextGroup.perSlot(<String>['country', 'serial']),
    );
  }
}
