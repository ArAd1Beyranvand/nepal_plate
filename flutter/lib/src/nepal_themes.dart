import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'nepal_colors.dart';

/// One ink on one field. The current plates carry a black frame; the
/// 1983–2019 ones are printed to the edge.
abstract final class NepalThemes {
  /// Black on white in a black frame (2020 series, every vehicle size).
  static final PlateTheme current = _ink(
    NepalColors.white,
    NepalColors.black,
    frame: 0.03,
  );

  static final PlateTheme legacyPrivate = _ink(
    NepalColors.red,
    NepalColors.white,
  );

  /// Commercial / public vehicles: white on black.
  static final PlateTheme legacyPublic = _ink(
    NepalColors.black,
    NepalColors.white,
  );

  static final PlateTheme legacyGovernment = _ink(
    NepalColors.white,
    NepalColors.red,
  );

  static final PlateTheme legacyCorporation = _ink(
    NepalColors.yellow,
    NepalColors.black,
  );

  static final PlateTheme legacyTourist = _ink(
    NepalColors.green,
    NepalColors.white,
  );

  static final PlateTheme legacyDiplomatic = _ink(
    NepalColors.blue,
    NepalColors.white,
  );
}

PlateTheme _ink(Color field, Color ink, {double frame = 0}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      borderWidthRatio: frame,
      plateRadiusRatio: 0.05,
    );
