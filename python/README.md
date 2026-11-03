FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the resilient people of Nepal to view examples:

https://platexample.ir/#/discover/nepal:python

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

### Install (Python)

Copy `python/plates/countries/nepal/` into `plate_core/python/plates/countries/`.

Then run the tests from `plate_core/python/`: `pytest`.

### Use

```python
from plates.countries.nepal.data import SPECS, THEMES

spec = SPECS["np.heavy_front"]
theme = THEMES["NepalThemes.current"]
print(spec.id)
```

## Specs

The specs are the same in every language (they come from shared data).

- `np.heavy_front`
- `np.car_front`
- `np.heavy_rear`
- `np.car_rear`
- `np.three_wheeler`
- `np.legacy`
- `np.legacy_diplomatic`

## Themes

- `NepalThemes.current`
- `NepalThemes.legacyPrivate`
- `NepalThemes.legacyPublic`
- `NepalThemes.legacyGovernment`
- `NepalThemes.legacyCorporation`
- `NepalThemes.legacyTourist`
- `NepalThemes.legacyDiplomatic`

## Change it

- Pick a spec: use another key of `SPECS`.
- Pick a theme: use another key of `THEMES`.
- Validators: `VALIDATORS` maps the names `NepalValidator`, `NepalLegacyValidator`, `NepalDiplomaticValidator` to classes.

## License

See [LICENSE](https://github.com/ArAd1Beyranvand/nepal_plate/blob/main/LICENSE).
