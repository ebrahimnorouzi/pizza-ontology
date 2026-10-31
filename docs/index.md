# Pizza Ontology

A pizza ontology built with OntoBoard from ontology design patterns, following the eXtreme Design methodology.

This site is published from the `docs/` folder of this repository by
GitHub Actions, every time `main` changes.

## Getting the ontology

| What | Where |
|---|---|
| Browse | `https://ebrahimnorouzi.github.io/pizza-ontology/pizza.owl` |
| Edit file | `src/ontology/pizza-edit.owl` |
| Released file | `pizza.owl` |

Edit the **edit file**, never the released one: the released file is produced
by the build and is overwritten by it.

## Turning this site on

GitHub does not publish Pages until it is asked. Once, in the repository's
**Settings > Pages**, set the source to **Deploy from a branch** and choose
the `gh-pages` branch - the workflow creates that branch the first time it
runs. The site then appears at `https://<owner>.github.io/<repository>/`.
