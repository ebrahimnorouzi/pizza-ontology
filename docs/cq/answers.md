# Competency questions, answered

Each query in this folder run against the released `pizza.owl` (reasoned with ELK), with OntoBoard > ROBOT > SPARQL... These answers are regenerated on every release.

## CQ1: What are the base and the toppings of the Margherita on the menu?

`cq1-components.rq` - 3 row(s)

| kind | part |
|---|---|
| base | thin and crispy base |
| topping | mozzarella topping |
| topping | tomato topping |

## CQ2: Which pizzas on the menu have mozzarella on them?

`cq2-pizzas-with-topping.rq` - 5 row(s)

| pizza |
|---|
| diavola (menu item) |
| funghi (menu item) |
| hawaiian (menu item) |
| margherita (menu item) |
| quattro formaggi (menu item) |

## CQ3: Which pizzas are spicy? Nobody asserted it: the reasoner puts them under SpicyPizza.

`cq3-spicy-pizzas.rq` - 1 row(s)

| pizza |
|---|
| diavola |
