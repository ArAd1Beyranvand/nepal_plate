import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:nepal_plate/nepal_plate.dart';

void main() => runApp(
  PlateExampleApp(spec: NepalPlates.heavyFront, theme: NepalThemes.current),
);
