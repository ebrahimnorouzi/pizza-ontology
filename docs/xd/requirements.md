# Requirements (eXtreme Design scoping)

eXtreme Design (XD) builds an ontology in small iterations. Each iteration takes one user story,
turns it into competency questions (CQs), finds the ontology design pattern (ODP) that answers
them, specialises that pattern, and tests the result against the CQs before the next iteration
starts. Each iteration here ends in a release with its own semantic version.

## User stories

| Story | As a... | I want to... | so that... | Iteration |
|---|---|---|---|---|
| S1 | pizzeria owner | describe what each pizza on my menu is made of - its base and toppings | customers can see the ingredients | 1 (v0.2.0) |
| S2 | customer | know which pizzas suit a vegetarian diet and how hot each one is | I can choose quickly | 2 (v0.3.0) |
| S3 | pizzeria owner | give every pizza on the menu a price in a currency | the menu can be printed and compared | 3 (v0.4.0) |

## Competency questions

| CQ | Question | Story | Answered by | Test |
|---|---|---|---|---|
| CQ1 | What are the base and the toppings of a given pizza? | S1 | `docs/cq/cq1-components.rq` | `src/sparql/cq1_every_pizza_has_a_base.rq` |
| CQ2 | Which pizzas have a given topping, e.g. mozzarella? | S1 | `docs/cq/cq2-pizzas-with-topping.rq` | `src/sparql/cq2_toppings_are_toppings.rq` |
| CQ3 | Which pizzas are spicy? | S1 | `docs/cq/cq3-spicy-pizzas.rq` (needs the reasoner) | reasoned release |
| CQ4 | Which pizzas are vegetarian? | S2 | `docs/cq/cq4-vegetarian-pizzas.rq` | `src/sparql/cq4_vegetarian_pizzas_have_no_meat.rq` |
| CQ5 | How hot is a given pizza? | S2 | `docs/cq/cq5-spiciness.rq` | `src/sparql/cq5_every_pizza_has_a_spiciness_level.rq` |
| CQ6 | How much does a given pizza cost, and in which currency? | S3 | `docs/cq/cq6-prices.rq` | `src/sparql/cq6_every_pizza_has_a_price.rq` |
| CQ7 | Which pizzas cost less than 10 euros? | S3 | `docs/cq/cq7-cheaper-than-10.rq` | - |

## Contextual statements

- A pizza has exactly one kind of base and one or more toppings.
- Toppings are grouped as cheese, meat, vegetable and fruit toppings; some are spicy.
- A menu item is a particular pizza with its own base, toppings, diet category, spiciness level
  and price.

## Reasoning requirements

- **SpicyPizza** is *defined*, not asserted: any pizza with at least one spicy topping. The
  reasoner must place `Diavola` under it, because spicy salami is a spicy topping.
- **CheesyPizza** likewise: any pizza with at least one cheese topping.
- Everything stays in OWL 2 EL, so ELK - the reasoner the in-process build uses - classifies it,
  and in OWL 2 DL, which `validate_profile` checks.

## Patterns chosen

Each chosen in *OntoBoard → ROBOT → Pattern library...* by searching for the CQ's words. The
library answers with patterns whose own competency questions match. All three are sound: the
library's reasoner check (`patterns/soundness.tsv` in OntoBoard) found each consistent with no
unsatisfiable class.

| Iteration | Pattern (library id) | Its own CQs | Specialised as |
|---|---|---|---|
| 1 | Componency (`componency`) | What are the components of this entity? What is this entity a component of? | `Pizza`, `PizzaBase`, `PizzaTopping` ⊑ `Object`; `hasBase`, `hasTopping` ⊑ `hasComponent` |
| 2 | Classification (`classification`) | What concept classifies this entity? What entities are classified by this concept? | `DietCategory`, `SpicinessLevel` ⊑ `Concept`; menu items `isClassifiedBy` `vegetarian`, `mild`, `hot` |
| 3 | Price (`price`) | How much does a given item cost, and in which currency? | `MenuPrice` ⊑ `Price`; `euro` a `Currency`; `hasPrice`, `hasCurrency`, `hasValue` |

Source: the ontology design patterns are from the ODP portal
(ontologydesignpatterns.org), bundled with OntoBoard; each import keeps the pattern's own IRIs.
