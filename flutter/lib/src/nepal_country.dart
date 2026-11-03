import 'dart:ui';

import 'package:plate_core/plate_core.dart';

import 'nepal_colors.dart';

/// Nepal as a `PlateCountry`. The current plates carry the flag in a left strip
/// of their own, drawn by the spec as a decal, so every spec sets `noPanel`.
abstract final class NepalCountry {
  /// The double-pennon flag, 71.57 × 87.25: the blue border is the silhouette
  /// pushed out by half the official 5.165 stroke, the crimson field the
  /// silhouette itself (coordinates from the Constitution's construction sheet,
  /// shifted so the drawing starts at 0,0). The moon is a bowl and the suns are
  /// 16- and 12-pointed stars; the construction's rays are simplified.
  static const PlateDrawing flagDrawing = PlateDrawing(
    71.57,
    87.25,
    <PlateShape>[
      PlatePolygonShape(<Offset>[
        Offset(0, 0),
        Offset(71.57, 44.82),
        Offset(26.39, 44.82),
        Offset(68.82, 87.25),
        Offset(0, 87.25),
      ], NepalColors.flagBlue),
      PlatePolygonShape(<Offset>[
        Offset(2.58, 4.66),
        Offset(62.58, 42.24),
        Offset(20.16, 42.24),
        Offset(62.58, 84.66),
        Offset(2.58, 84.66),
      ], NepalColors.flagCrimson),
      PlateCircleShape(17.58, 28.14, 11.95, NepalColors.white),
      PlateCircleShape(17.58, 23.44, 12.84, NepalColors.flagCrimson),
      PlateStarShape(
        17.58,
        33.71,
        7.7,
        NepalColors.white,
        points: 16,
        innerRatio: 0.72,
      ),
      PlateStarShape(
        17.58,
        63.45,
        12.8,
        NepalColors.white,
        points: 12,
        innerRatio: 0.64,
      ),
    ],
  );

  static const PlateCountry nepal = PlateCountry(
    code: 'np',
    panelColor: NepalColors.flagCrimson,
    panelTextColor: NepalColors.white,
    flagAspectRatio: 71.57 / 87.25,
    flag: flagDrawing,
  );
}
