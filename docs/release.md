# Releasing Pizza Ontology

A release is a dated, frozen copy that other ontologies can import and that
will not change under them.

1. Make sure `test` passes.
2. **OntoBoard > Project > Release...**, which stamps a version IRI of the
   form `https://ebrahimnorouzi.github.io/pizza-ontology/pizza/releases/YYYY-MM-DD/pizza.owl`
   and writes both the dated copy and the published `pizza.owl`.
3. Commit both, tag the commit, and push.

A version IRI cannot be taken back once somebody has imported it, so the
release step refuses to overwrite a release that already exists.
