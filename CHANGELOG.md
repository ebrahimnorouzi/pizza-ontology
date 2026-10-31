# Changelog

All notable changes to the Pizza Ontology. Versions follow [Semantic Versioning](https://semver.org/);
each one is a release under `releases/<version>/` and a git tag `v<version>`.

## [1.0.0] - 2026-10-31

### Changed
- First stable release. No change to the terms since 0.4.0: the three iterations are integrated,
  every CQ test passes, the quality report has no errors and the ontology is in OWL 2 DL.
  From here on a patch release changes no term, a minor one adds terms, a major one removes or
  redefines one.

## [0.4.0] - 2026-10-31

### Added
- Iteration 3 (story S3, CQ6-CQ7): the **Price** pattern imported as `imports/price_import.owl`
  and specialised: `MenuPrice` under `Price`, `euro` a `Currency`, and a price with a value and a
  currency for every menu item.
- CQ test `cq6_every_pizza_has_a_price.rq`; CQ6 and CQ7 queries and answers in `docs/cq/`.

## [0.3.0] - 2026-10-31

### Added
- Iteration 2 (story S2, CQ4-CQ5): the **Classification** pattern imported as
  `imports/classification_import.owl` and specialised: `DietCategory` and `SpicinessLevel` under
  `Concept`; `vegetarian`, `mild` and `hot`; every menu item `isClassifiedBy` its spiciness level,
  and the vegetarian ones by `vegetarian`.
- CQ tests `cq4_vegetarian_pizzas_have_no_meat.rq`, `cq5_every_pizza_has_a_spiciness_level.rq`;
  CQ4 and CQ5 queries and answers in `docs/cq/`.

## [0.2.0] - 2026-10-31

### Added
- Iteration 1 (story S1, CQ1-CQ3): the **Componency** pattern imported from OntoBoard's library as
  `imports/componency_import.owl`, and specialised: `Pizza`, `PizzaBase`, `PizzaTopping`, the
  `hasBase` and `hasTopping` subproperties of `hasComponent`, two bases, eleven toppings in four
  groups, five named pizzas, and the defined classes `SpicyPizza` and `CheesyPizza`.
- One menu item per named pizza, with its base and toppings, as test data.
- CQ tests `src/sparql/cq1_every_pizza_has_a_base.rq`, `cq2_toppings_are_toppings.rq`; CQ queries
  and answers in `docs/cq/`. The reasoner infers `Diavola` under `SpicyPizza` (CQ3).

## [0.1.0] - 2026-10-31

### Added
- Project scaffolded with OntoBoard 1.129.0 (*Project → New ODK project...*).
- XD scoping: user stories S1-S3, competency questions CQ1-CQ7, contextual statements and
  reasoning requirements in `docs/xd/requirements.md`.
