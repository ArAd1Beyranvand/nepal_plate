import 'package:nepal_plate/nepal_plate.dart';
import 'package:plate_core/testing.dart';

void main() {
  plateGoldens('np', NepalCountry.nepal, <String, PlateGoldenCase>{
    'heavy_front': (
      NepalPlates.heavyFront,
      NepalThemes.current,
      'BAGMATI G AB 0123',
    ),
    'car_front': (
      NepalPlates.carFront,
      NepalThemes.current,
      'BAGMATI B AB 0123',
    ),
    'heavy_rear': (
      NepalPlates.heavyRear,
      NepalThemes.current,
      'BAGMATI G AB 0123',
    ),
    'car_rear': (NepalPlates.carRear, NepalThemes.current, 'BAGMATI B AB 0123'),
    'three_wheeler': (
      NepalPlates.threeWheeler,
      NepalThemes.current,
      'BAGMATI C AB 0123',
    ),
    'legacy_private': (
      NepalPlates.legacy,
      NepalThemes.legacyPrivate,
      'बा 12 क 3456',
    ),
    'legacy_public': (
      NepalPlates.legacy,
      NepalThemes.legacyPublic,
      'बा 1 ख 3456',
    ),
    'legacy_government': (
      NepalPlates.legacy,
      NepalThemes.legacyGovernment,
      'बा 1 ग 3456',
    ),
    'legacy_corporation': (
      NepalPlates.legacy,
      NepalThemes.legacyCorporation,
      'बा 1 घ 3456',
    ),
    'legacy_tourist': (
      NepalPlates.legacy,
      NepalThemes.legacyTourist,
      'बा 1 य 3456',
    ),
    'legacy_diplomatic': (
      NepalPlates.legacyDiplomatic,
      NepalThemes.legacyDiplomatic,
      '01 23',
    ),
  });
}
