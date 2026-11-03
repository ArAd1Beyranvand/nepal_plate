FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Nepal to view examples:

https://platexample.ir/#/discover/nepal:flutter

# nepal_plate

Nepal's licence plates for the plate_core library: the 2020 series and the 1983–2019 Devanagari series, with themes, alphabets and advisory validators.

## Languages

| Language | Folder | Example |
| --- | --- | --- |
| Flutter / Dart | [`flutter/`](https://github.com/ArAd1Beyranvand/nepal_plate/tree/main/flutter) | [platexample](https://platexample.ir/#/discover/nepal:flutter) |
| Kotlin | [`kotlin/`](https://github.com/ArAd1Beyranvand/nepal_plate/tree/main/kotlin) | [platexample](https://platexample.ir/#/discover/nepal:kotlin) |
| Python | [`python/`](https://github.com/ArAd1Beyranvand/nepal_plate/tree/main/python) | [platexample](https://platexample.ir/#/discover/nepal:python) |
| TypeScript | [`typescript/`](https://github.com/ArAd1Beyranvand/nepal_plate/tree/main/typescript) | [platexample](https://platexample.ir/#/discover/nepal:typescript) |

## Quick start

### Install

```yaml
dependencies:
  plate_core: ^0.12.0
  nepal_plate: ^0.1.0
```

### Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:nepal_plate/nepal_plate.dart';

PlateCanvas(
  spec: NepalPlates.heavyFront,
  theme: NepalThemes.current,
  validator: const NepalValidator(),
  autoValidate: true,
  onChooseCharacter: noCharacterChooser,
);
```

## Specs

Each spec is one plate layout.

- `NepalPlates.heavyFront`
- `NepalPlates.carFront`
- `NepalPlates.heavyRear`
- `NepalPlates.carRear`
- `NepalPlates.threeWheeler`
- `NepalPlates.legacy`
- `NepalPlates.legacyDiplomatic`

## Themes

- `NepalThemes.current`
- `NepalThemes.legacyPrivate`
- `NepalThemes.legacyPublic`
- `NepalThemes.legacyGovernment`
- `NepalThemes.legacyCorporation`
- `NepalThemes.legacyTourist`
- `NepalThemes.legacyDiplomatic`

## Change it

`PlateCanvas` takes `spec:` (an entry of `NepalPlates`) and `theme:` (an entry of `NepalThemes`). Set `validator:` to `NepalValidator()` and `autoValidate: true` to show validation hints.

## Also included

- `NepalCountry` — the country panel.
- `NepalValidator` — the plate validator.

## Plates

Nepal's plates: the 2020 series and the 1983–2019 series it replaced.

**2020 series** (Latin, black on white, a left strip with the flag and a
blue `NEP`): `BAGMATI B AB 0123`, a province, a class code, two series
letters and four digits. Two designs: *front* (caption above one serial row)
and *rear* (caption, class and letters, number on three rows), the rear in
three physical sizes. A field is one slot: the province is a picked name, the
class one or two characters (`C`, `C1`), the series two letters, the
number four digits. Pair every one with `NepalThemes.current`.

**1983–2019 series** (Devanagari): zone code, a one or two digit lot, a
class letter and four digits, over two rows. One design serves private,
public, government, national corporation and tourist plates; the category is
the theme and the class letters the picker offers. The diplomatic plate has
its own: the country number, a fixed `सी.डी.` and a serial, echoed in Latin
below. Zone and class are picked from alphabets; the class letters are the
article's table, and the colours of each category come from the photographs.

Not implemented: the narrow one-line front plates of the 1983–2019 series
(their photographs are close crops that did not fit, and the national
corporation front was not fitted at all); sizes of the 1983–2019 plates.
The 1983–2019 numerals are stored as `0-9` and printed in Devanagari.

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/nepal_plate/blob/main/LICENSE).
