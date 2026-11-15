# Pizza Ontology

A small ontology of pizzas - what they are made of, which diet they suit, how hot they are and
what they cost - built in Protégé with [OntoBoard](https://ebrahimnorouzi.github.io/ontoboard/)
from three ontology design patterns, following the **eXtreme Design** (XD) methodology.

It is meant to be read as a worked example: every step below is one OntoBoard menu action, every
iteration ends in a release with a [semantic version](https://semver.org/), and every release is
a git tag, so you can check out any step and compare it with what you built.

| | |
|---|---|
| Ontology IRI | `https://ebrahimnorouzi.github.io/pizza-ontology/pizza.owl` |
| Latest release | [`pizza.owl`](pizza.owl) and [`pizza-full.owl`](pizza-full.owl) - imports merged, reasoned with ELK; each version under [`releases/`](releases/) |
| Version IRIs | `https://ebrahimnorouzi.github.io/pizza-ontology/pizza/<version>` |
| Documentation | [The ontology's documentation page](https://ebrahimnorouzi.github.io/pizza-ontology/ontology/index-en.html), written by *OntoBoard > Build and release > Documentation...* (Widoco); the [project site](https://ebrahimnorouzi.github.io/pizza-ontology/) |
| Licence | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |
| Built with | OntoBoard 1.153.0 in Protégé: an ODK project, its targets run by OntoBoard itself - nothing else installed, no Docker |
| Patterns | Componency, Classification, Price - from the ODP portal, bundled with OntoBoard |

## Made again with OntoBoard 1.153.0

This repository was first built with OntoBoard 1.130.0, in the project layout of its own that
OntoBoard used up to 1.135. On 2026-11-15 every release was made again with OntoBoard 1.153.0:
the project of each tag carried over by *OntoBoard > Project > Update project files...* into the
layout the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit) (ODK)
v1.6.1 writes, committed, and released by *OntoBoard > Build and release > Release...*, which
runs ODK's own `prepare_release` - inside Protégé, by OntoBoard itself. Each release holds the
ontology it always held, under the version IRI it was published with. The steps below say how to
make the same with 1.153.0.

One thing was taken out on the way: OntoBoard 1.135 wrote `owl:versionInfo "0.1.0"` into the edit
file, and ODK's release writes the release's own, so the old one is gone from the first commit on.

## What you need

1. [Protégé Desktop](https://protege.stanford.edu/) 5.5.0 or 5.6.x.
2. OntoBoard **1.153.0**: put `ontoboard-1.153.0.jar` in Protégé's `plugins` folder (remove any
   other `ontoboard-*.jar` first) and restart Protégé.
3. Check it: *OntoBoard > Run self-test*. The line `Build and release > Build (nothing installed)
   | ok` means that ODK's targets below run inside Protégé, with nothing else installed.

## The steps

Each step lists the menu actions and the tag that holds the result. Every release is two commits:
the iteration's work, then the release, tagged. Compare your work with a tag at any point:
`git diff v0.2.0 -- src/ontology/pizza-edit.owl`.

### v0.1.0 - Start the project and write down the requirements

1. *OntoBoard > Project > New ODK project...*: ID `pizza`, title `Pizza Ontology`, Base IRI
   `https://ebrahimnorouzi.github.io/pizza-ontology/pizza.owl` (use one **you** own - see
   [Your own IRI](#your-own-iri)), licence CC BY 4.0. It writes the project ODK itself writes -
   `src/ontology/pizza-edit.owl`, ODK's configuration, Makefile and checks, a CI workflow and a
   documentation site - and makes it a git repository.
2. Write the XD scoping before modelling anything: user stories, competency questions,
   contextual statements and reasoning requirements - [`docs/xd/requirements.md`](docs/xd/requirements.md).
3. *OntoBoard > Build and release > Build...* → `test`: the reasoner, ODK's checks, the quality
   report and the OWL profile all pass on the empty project.
4. *OntoBoard > Share > Git...* → *Commit everything, with a message*. Then *OntoBoard > Build and
   release > Release...*: version `0.1.0`, the version IRI `<ontbase>/<version>` - here
   `https://ebrahimnorouzi.github.io/pizza-ontology/pizza/0.1.0` - and *Commit and tag*.

### v0.2.0 - Iteration 1: what a pizza is made of (Componency)

Story S1, CQ1-CQ3.

1. *OntoBoard > Reuse > Pattern library...*: search `components`. Pick **Componency Pattern**,
   press **Import terms...**, then **Add them**. OntoBoard cuts the pattern's terms, with what
   they need, into `src/ontology/imports/componency_import.owl`, lists them in
   `componency_terms.txt`, imports the module with a catalog entry, and declares it in the ODK
   configuration as a module of the project's own, which ODK's refresh leaves as it is. On the
   board the pattern's classes arrive inside a frame named after it.
2. Specialise the pattern in `pizza-edit.owl` (Protégé's class and property tabs, or the board):
   - `Pizza`, `PizzaBase`, `PizzaTopping` subclasses of the pattern's `Object`;
   - `hasBase` and `hasTopping` subproperties of `hasComponent`, domain `Pizza`, ranges
     `PizzaBase` and `PizzaTopping`; `Pizza SubClassOf hasBase some PizzaBase`;
   - the bases, the topping hierarchy (cheese, meat, vegetable, fruit; spicy salami and chili
     pepper also under `SpicyTopping`), and five named pizzas under `NamedPizza`, each with
     `hasTopping some ...` for its toppings;
   - **defined** classes `SpicyPizza ≡ Pizza and (hasTopping some SpicyTopping)` and
     `CheesyPizza ≡ Pizza and (hasTopping some CheeseTopping)`;
   - one menu item per pizza (an individual with its base and toppings) - the test data.
   Give **every** term an `rdfs:label`: the project's label check fails the build on a class
   without one, and the build says which.
3. Turn CQ1 and CQ2 into tests in `src/sparql/` - each query returns the terms that **break** the
   rule, so an empty answer passes. *OntoBoard > Check and test > Write a test from a question...*
   writes such a test for the common rules; these were written by hand.
4. *Build...* → `test` passes. Reasoner (*Reasoner → ELK*, *Start reasoner*): `Diavola` is now
   under `SpicyPizza`, and every named pizza under `CheesyPizza`.
5. Commit, then *Release...* → `0.2.0`.

### v0.3.0 - Iteration 2: diet and spiciness (Classification)

Story S2, CQ4-CQ5.

1. *Pattern library...*: search `classifies`, import **Classification Pattern**.
2. `DietCategory` and `SpicinessLevel` subclasses of `Concept`; individuals `vegetarian`, `mild`,
   `hot`; each menu item `isClassifiedBy` its diet (if vegetarian) and its spiciness level.
3. Tests: no pizza classified vegetarian has a meat topping (CQ4), every menu item has a
   spiciness level (CQ5).
4. *Build...* → `test` passes. Commit, then *Release...* → `0.3.0`.

### v0.4.0 - Iteration 3: what a pizza costs (Price)

Story S3, CQ6-CQ7.

1. *Pattern library...*: search `cost`, import **Price Pattern**.
2. `MenuPrice` subclass of `Price`; individual `euro` a `Currency`; each menu item `hasPrice` a
   `MenuPrice` that `hasCurrency euro` and `hasValue` an `xsd:decimal`.
3. Test: every menu item has a price with a value and a currency (CQ6).
4. *Build...* → `test` passes. Commit, then *Release...* → `0.4.0`.

### v1.0.0 - Integration and the first stable release

1. *Build...* → `test` over the whole ontology: all CQ tests pass, the quality report has no
   errors, and the ontology is in OWL 2 DL.
2. Answer every CQ with *OntoBoard > Check and test > SPARQL...* using the queries in
   [`docs/cq/`](docs/cq/), against the released `pizza.owl`. The answers are in
   [`docs/cq/answers.md`](docs/cq/answers.md).
3. *Release...* → `1.0.0`. From here on the version says what changed: a patch for a fix that
   changes no term, a minor for new terms, a major for anything removed or redefined.

ODK's build checks consistency with ELK, as ODK's Makefile does, and ELK passes 1.0.0. HermiT
does not: the Price pattern gives `price:hasValue` the range `xsd:float`, and the prices are written
as `xsd:decimal`, so the menu items cannot exist. The release is kept as it was published; the fix
- a decimal range, or float values - is a patch release.

### See the patterns on the board

Open `src/ontology/pizza-edit.owl` and go to the **OntoBoard** tab: Componency, Classification and
Price each in a frame named after the pattern, the pizza's own classes as an outline below them -
a class, then its subclasses, then its individuals - and the properties in frames of their own.
Select a class to bring what it is connected to forward.

## Versioning

[Semantic versioning](https://semver.org/): `MAJOR.MINOR.PATCH`. Each release - ODK's
`prepare_release` - stamps `owl:versionIRI <ontbase>/<version>` and `owl:versionInfo`, and is kept
under `releases/<version>/`, from the second release on with `CHANGES.md`, what changed term by
term. Below 1.0.0 each XD iteration is one minor version. See [`CHANGELOG.md`](CHANGELOG.md).

To walk through the evolution in Protégé, open `src/ontology/pizza-edit.owl` and choose
*OntoBoard > Build and release > History...*: every release with what it holds and what changed
in it, and any of them opened in a window of its own.

## Layout

| Path | What |
|---|---|
| `src/ontology/pizza-edit.owl` | The file you edit. Imports the three pattern modules. |
| `src/ontology/pizza-odk.yaml` | ODK's configuration: the imports, the checks, what a release writes |
| `src/ontology/Makefile`, `run.sh` | ODK's own. `pizza.Makefile` holds the project's own rules - OntoBoard's rule that asks the project's questions |
| `src/ontology/imports/` | One module per pattern, and the term list it was cut from |
| `src/sparql/` | ODK's checks, and the CQ tests the build runs |
| `docs/xd/requirements.md` | User stories, CQs, reasoning requirements, pattern choices |
| `docs/cq/` | One SPARQL query per CQ, and their answers |
| `docs/ontology/` | The documentation page, as *Documentation...* wrote it; published with the site |
| `docs/pizza.owl`, `docs/pizza/` | The latest release and every version, published under their IRIs |
| `pizza.owl`, `pizza-full.owl`, `releases/` | Releases: imports merged, reasoned with ELK |

The same build runs without Protégé, with ODK itself: `cd src/ontology && sh run.sh make test`
(Docker and ODK's image). That is what `.github/workflows/qc.yml` does on every push.

## Your own IRI

The IRIs here assume this repository is published as `pizza-ontology` with GitHub Pages. To use
your own: choose the Base IRI in step 1, or rename later with *OntoBoard > Terms > Rename IRIs...*.

## Licence and credit

The Pizza Ontology is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
The idea of a pizza ontology for teaching follows the Manchester OWL pizza tutorial; the patterns
are from the ODP portal (ontologydesignpatterns.org) and keep their own IRIs.
