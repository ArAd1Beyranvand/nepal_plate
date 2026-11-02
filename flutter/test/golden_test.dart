import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nepal_plate/nepal_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
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
        'car_rear': (
          NepalPlates.carRear,
          NepalThemes.current,
          'BAGMATI B AB 0123',
        ),
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
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: NepalCountry.nepal,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/np_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
