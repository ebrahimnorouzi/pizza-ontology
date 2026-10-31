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

## CQ4: Which pizzas on the menu are vegetarian?

`cq4-vegetarian-pizzas.rq` - 3 row(s)

| pizza |
|---|
| funghi (menu item) |
| margherita (menu item) |
| quattro formaggi (menu item) |

## CQ5: How hot is each pizza on the menu?

`cq5-spiciness.rq` - 5 row(s)

| pizza | level |
|---|---|
| diavola (menu item) | hot |
| funghi (menu item) | mild |
| hawaiian (menu item) | mild |
| margherita (menu item) | mild |
| quattro formaggi (menu item) | mild |

## CQ6: How much does each pizza on the menu cost, and in which currency?

`cq6-prices.rq` - 5 row(s)

| pizza | amount | currency |
|---|---|---|
| diavola (menu item) | 10.50 | euro |
| funghi (menu item) | 9.50 | euro |
| hawaiian (menu item) | 10.00 | euro |
| margherita (menu item) | 8.50 | euro |
| quattro formaggi (menu item) | 11.00 | euro |

## CQ7: Which pizzas cost less than 10 euros?

`cq7-cheaper-than-10.rq` - 2 row(s)

| pizza | amount |
|---|---|
| margherita (menu item) | 8.50 |
| funghi (menu item) | 9.50 |
