import 'package:plate_core/plate_core.dart';

// TODO(py): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
// TODO(ts): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
// TODO(kt): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
// TODO(py): [H9] Python re: \d/\w match Unicode; keep explicit [0-9]/[A-Z] classes (or re.ASCII).
// TODO(ts): [H9] same flavour as Dart; port as is, cover accept/reject in the vectors (D9).
// TODO(kt): [H9] Regex engine differs per target (JVM/JS/Native): keep to portable syntax.
/// Judges a plate of the 2020 series: `BAGMATI B AB 0123`. Reports, never bars
/// a keystroke.
///
/// Groups: `province`, `class` (`A`–`K`, or a sub-class such as `C1`),
/// `series` (two letters) and `number` (four digits).
class NepalValidator extends GatedPlateValidator {
  const NepalValidator();

  @override
  String get gateGroup => 'number';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('province').isEmpty) {
      return const PlateValidation.invalid('Choose a province.');
    }
    if (!RegExp(r'^[A-K][1-5]?$').hasMatch(entry.group('class'))) {
      return const PlateValidation.invalid(
        'The class is a letter A to K, with a digit for a sub-class.',
      );
    }
    if (!RegExp(r'^[A-Z]{2}$').hasMatch(entry.group('series'))) {
      return const PlateValidation.invalid('The series is two letters.');
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid('The number is 4 digits.');
    }
    return const PlateValidation.valid();
  }
}

// TODO(py): [H9] Python re: \d/\w match Unicode; keep explicit [0-9]/[A-Z] classes (or re.ASCII).
// TODO(ts): [H9] same flavour as Dart; port as is, cover accept/reject in the vectors (D9).
// TODO(kt): [H9] Regex engine differs per target (JVM/JS/Native): keep to portable syntax.
/// Judges a plate of the 1983–2019 series: zone, a one or two digit lot, a
/// class letter and four digits (`X # X ####`).
class NepalLegacyValidator extends GatedPlateValidator {
  const NepalLegacyValidator();

  @override
  String get gateGroup => 'number';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (entry.group('zone').isEmpty) {
      return const PlateValidation.invalid('Choose a zone.');
    }
    if (!RegExp(r'^[0-9]{1,2}$').hasMatch(entry.group('lot'))) {
      return const PlateValidation.invalid('The lot is 1 or 2 digits.');
    }
    if (entry.group('class').isEmpty) {
      return const PlateValidation.invalid('Choose a class letter.');
    }
    if (!isDigitsOfLength(entry.group('number'), 4)) {
      return const PlateValidation.invalid('The number is 4 digits.');
    }
    return const PlateValidation.valid();
  }
}

// TODO(py): [H9] Python re: \d/\w match Unicode; keep explicit [0-9]/[A-Z] classes (or re.ASCII).
// TODO(ts): [H9] same flavour as Dart; port as is, cover accept/reject in the vectors (D9).
// TODO(kt): [H9] Regex engine differs per target (JVM/JS/Native): keep to portable syntax.
/// Judges a 1983–2019 diplomatic plate: a country or organisation number, the
/// fixed `C.D.` and a serial, each 1 or 2 digits.
class NepalDiplomaticValidator extends GatedPlateValidator {
  const NepalDiplomaticValidator();

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) {
    final RegExp digits = RegExp(r'^[0-9]{1,2}$');
    if (!digits.hasMatch(entry.group('country'))) {
      return const PlateValidation.invalid(
        'The country number is 1 or 2 digits.',
      );
    }
    if (!digits.hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid('The serial is 1 or 2 digits.');
    }
    return const PlateValidation.valid();
  }
}
