import 'package:flutter/widgets.dart';

/// The colours of the Nepali plates, sampled from the flattened,
/// colour-balanced reference photographs (`.plateref/np/brief.md`); the flag's
/// two are the official ones from its construction sheet.
abstract final class NepalColors {
  /// Current plates: black ink on a white field.
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The blue `NEP` under the flag: `2F57A8`.
  static const Color nepBlue = Color(0xFF2F57A8);

  /// 1983–2019 private field, and government ink: `D8272D`.
  static const Color red = Color(0xFFD8272D);

  /// National corporation field: `FFBE00`.
  static const Color yellow = Color(0xFFFFBE00);

  /// Diplomatic field: `047AC0`.
  static const Color blue = Color(0xFF047AC0);

  /// Tourist field: `007B63`.
  static const Color green = Color(0xFF007B63);

  /// The flag's crimson and border blue.
  static const Color flagCrimson = Color(0xFFDC143C);
  static const Color flagBlue = Color(0xFF003893);
}
