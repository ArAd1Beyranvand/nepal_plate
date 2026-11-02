/// Nepal's 2020-series and 1983–2019 licence plates for the `plate_core`
/// library, with advisory validators.
library;

// TODO(py): [D5] one module `plates.countries.nepal`; assets via importlib.resources.
// TODO(ts): [D5] one subpath export `./countries/nepal`; tree-shakable.
// TODO(kt): [D5] package `countries.nepal` in the countries module.
export 'package:plate_alphabet/plate_alphabet.dart' show NepalAlphabets;
export 'src/nepal_colors.dart';
export 'src/nepal_country.dart';
export 'src/nepal_plates.dart';
export 'src/nepal_themes.dart';
export 'src/nepal_validators.dart';
