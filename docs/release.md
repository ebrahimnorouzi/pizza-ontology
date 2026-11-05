# Releasing Pizza Ontology

A release is a frozen copy that other ontologies can import and that will not
change under them. This project numbers its releases semantically:
`MAJOR.MINOR.PATCH`.

1. Make sure `test` passes: **OntoBoard > Build and release > Build...**,
   target `test`.
2. **OntoBoard > Build and release > Release...**, *Semantic version*, the next
   version. It stamps the version IRI
   `https://ebrahimnorouzi.github.io/pizza-ontology/pizza/<version>`, with `owl:versionInfo` and
   `owl:priorVersion`, and writes `releases/<version>/pizza.owl` and the
   published `pizza.owl`.
3. Publish the release under its IRIs: copy `pizza.owl` to `docs/pizza.owl`, and
   `releases/<version>/pizza.owl` to `docs/pizza/<version>` - with no extension,
   as in the version IRI. This site serves them at those addresses.
4. **OntoBoard > Build and release > Documentation...**, *Write it to*
   `docs/ontology`, *Include the WebVowl diagram* ticked. It documents the
   release you just made, and its changelog compares that release with the one
   before it - which has to be online already, as step 3 of the last release
   put it.
5. Commit all of it, tag the commit `v<version>`, and push. This site is
   republished from `main`.

A version IRI cannot be taken back once somebody has imported it, so the
release step refuses to overwrite a release that already exists.
