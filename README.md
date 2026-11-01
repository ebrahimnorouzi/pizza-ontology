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
| Latest release | [`pizza.owl`](pizza.owl) (RDF/XML), [`pizza.ttl`](pizza.ttl) (Turtle), each version under [`releases/`](releases/) |
| Licence | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |
| Built with | OntoBoard 1.130.0 - nothing else installed: no ROBOT, no ODK, no Docker |
| Patterns | Componency, Classification, Price - from the ODP portal, bundled with OntoBoard |

## What you need

1. [Protégé Desktop](https://protege.stanford.edu/) 5.5.0 or 5.6.x.
2. OntoBoard **1.130.0**: put `ontoboard-1.130.0.jar` in Protégé's `plugins` folder (remove any
   other `ontoboard-*.jar` first) and restart Protégé.
3. Check it: *OntoBoard → Run self-test*. The line `Project > Build (nothing installed) | ok`
   means the whole build below will run inside Protégé.

The exact OntoBoard version matters: the pattern library and the build are part of it, and
another version may extract a slightly different module. With 1.130.0 the modules and term lists
in `src/ontology/imports/` come out as they are here, apart from the date each module records for
its import (`dcterms:created`) and, in Protégé 5.6, two lines its newer OWL API writes: a
declaration of `xsd:date`, and its own version in the closing comment.

## The steps

Each step lists the menu actions, what the build must show, and the tag holding the result.
Compare your work with a tag at any point: `git diff v0.2.0 -- src/ontology/pizza-edit.owl`.

### v0.1.0 - Start the project and write down the requirements

1. *OntoBoard → Project → New ODK project...*: ID `pizza`, title `Pizza Ontology`, Base IRI
   `https://ebrahimnorouzi.github.io/pizza-ontology/pizza.owl` (use one **you** own - see
   [Your own IRI](#your-own-iri)), licence CC BY 4.0. It writes `src/ontology/pizza-edit.owl`,
   the Makefile, a quality profile, a CI workflow and a documentation site.
2. Write the XD scoping before modelling anything: user stories, competency questions,
   contextual statements and reasoning requirements - [`docs/xd/requirements.md`](docs/xd/requirements.md).
3. *OntoBoard → Project → Build...* → `test`: reason, report, sparql_test and validate_profile all
   pass on the empty project.
4. *OntoBoard → Project → Release...*: version scheme **Semantic**, version `0.1.0`.

### v0.2.0 - Iteration 1: what a pizza is made of (Componency)

Story S1, CQ1-CQ3.

1. *OntoBoard → ROBOT → Pattern library...*: search `components`. Pick **Componency Pattern**,
   press **Import terms...**, and **OK** in the dialog that follows. OntoBoard copies the pattern
   to `src/ontology/mirror/`, extracts a module of its terms to
   `src/ontology/imports/componency_import.owl`, records the terms and the pattern in
   `componency_terms.txt`, maps the module in `catalog-v001.xml` and adds the `owl:imports`. On
   the board the pattern's classes arrive inside a frame named after it. A pattern is not listed
   in the ODK configuration, so nothing ever downloads it: to change its module, import it again.
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
   Give **every** term an `rdfs:label`: the project's own `src/sparql/check_labels.rq` fails the
   build on a class without one, and the build tells you which.
3. Turn CQ1 and CQ2 into tests in `src/sparql/` - each query returns the terms that **break** the
   rule, so an empty answer passes. The first `#` line of each file is what the build reports
   when it fails.
4. *Build...* → `test` passes. Reasoner (*Reasoner → ELK*, *Start reasoner*): `Diavola` is now
   under `SpicyPizza`, and every named pizza under `CheesyPizza`.
5. *Release...* → `0.2.0`.

### v0.3.0 - Iteration 2: diet and spiciness (Classification)

Story S2, CQ4-CQ5.

1. *Pattern library...*: search `classifies`, import **Classification Pattern**.
2. `DietCategory` and `SpicinessLevel` subclasses of `Concept`; individuals `vegetarian`, `mild`,
   `hot`; each menu item `isClassifiedBy` its diet (if vegetarian) and its spiciness level.
3. Tests: no pizza classified vegetarian has a meat topping (CQ4), every menu item has a
   spiciness level (CQ5).
4. *Build...* → `test` passes. *Release...* → `0.3.0`.

### v0.4.0 - Iteration 3: what a pizza costs (Price)

Story S3, CQ6-CQ7.

1. *Pattern library...*: search `cost`, import **Price Pattern**.
2. `MenuPrice` subclass of `Price`; individual `euro` a `Currency`; each menu item `hasPrice` a
   `MenuPrice` that `hasCurrency euro` and `hasValue` an `xsd:decimal`.
3. Test: every menu item has a price with a value and a currency (CQ6).
4. *Build...* → `test` passes. *Release...* → `0.4.0`.

### v1.0.0 - Integration and the first stable release

1. *Build...* → `test` over the whole ontology: all CQ tests pass, the quality report has no
   errors, and the ontology is in OWL 2 DL.
2. Answer every CQ with *OntoBoard → ROBOT → SPARQL...* using the queries in
   [`docs/cq/`](docs/cq/), against the released `pizza.owl`. The answers are in
   [`docs/cq/answers.md`](docs/cq/answers.md).
3. *Release...* → `1.0.0`. From here on the version says what changed: a patch for a fix that
   changes no term, a minor for new terms, a major for anything removed or redefined.

### See the patterns on the board

Open `src/ontology/pizza-edit.owl` - or the release, `pizza.owl` - and go to the **OntoBoard** tab.
From OntoBoard 1.131.0 the board shows the whole ontology as soon as it opens: Componency,
Classification and Price each in a frame named after the pattern along the top, the pizza's own
classes as an outline below them - a class, then its subclasses, then its individuals - and the
properties in frames of their own. Select a class to bring what it is connected to forward. With
1.130.0, which built this repository, press **Add all** for the frames. On a Mac, pinch to zoom.

## Versioning

[Semantic versioning](https://semver.org/): `MAJOR.MINOR.PATCH`. Each release stamps
`owl:versionIRI <ontology>/<version>`, `owl:versionInfo` and `owl:priorVersion` (the release
before it), and is kept under `releases/<version>/pizza.owl`. Below 1.0.0 each XD iteration is one
minor version. See [`CHANGELOG.md`](CHANGELOG.md).

To walk through the evolution in Protégé, open `src/ontology/pizza-edit.owl` and choose
*OntoBoard → Project → History...*: every release with what it holds and what changed in it -
0.2.0 adds the Componency pattern's terms and the pizzas, 0.3.0 the diet and spiciness, 0.4.0 the
prices - and any of them opened in a window of its own.

## Layout

| Path | What |
|---|---|
| `src/ontology/pizza-edit.owl` | The file you edit. Imports the three pattern modules. |
| `src/ontology/imports/` | One module per pattern, and the term list it was extracted from |
| `src/sparql/` | The CQ tests the build runs (`sparql_test`) |
| `docs/xd/requirements.md` | User stories, CQs, reasoning requirements, pattern choices |
| `docs/cq/` | One SPARQL query per CQ, and their answers |
| `pizza.owl`, `pizza.ttl`, `releases/` | Releases: imports merged, reasoned with ELK |

The same build runs without Protégé wherever `make` and [ROBOT](https://robot.obolibrary.org/)
are installed: `cd src/ontology && make test`. That is what `.github/workflows/qc.yml` does.

## Your own IRI

The IRIs here assume this repository is published as `pizza-ontology` with GitHub Pages. To use
your own: choose the Base IRI in step 1, or rename later with *OntoBoard → ROBOT → Rename IRIs...*.

## Licence and credit

The Pizza Ontology is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
The idea of a pizza ontology for teaching follows the Manchester OWL pizza tutorial; the patterns
are from the ODP portal (ontologydesignpatterns.org) and keep their own IRIs.
