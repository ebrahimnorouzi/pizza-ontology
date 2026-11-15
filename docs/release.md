# Releasing Pizza Ontology

A release is a frozen, numbered copy that other ontologies can import and that will not change
under them. This project numbers its releases semantically: `MAJOR.MINOR.PATCH`.

1. Make sure `test` passes: **OntoBoard > Build and release > Build...**, target `test`.
2. Commit your work: **OntoBoard > Share > Git...**, *Commit everything, with a message*. A
   release commits the files it changed and its own; a new file it has never been told about is
   not in the release's commit.
3. **OntoBoard > Build and release > Release...**: the next version, and the version IRI in the
   shape this project's releases have, `<ontbase>/<version>` -
   `https://ebrahimnorouzi.github.io/pizza-ontology/pizza/<version>`. It runs ODK's `make clean` and `prepare_release`, which build the
   release files and put them at the top of the repository, `pizza.owl` among them, and copies
   them to `releases/<version>/`, with `CHANGES.md` from the second release on.
4. It then shows the git commands it is about to run, and runs them when you agree: the release
   files are committed - ODK keeps them out of git until then - and the commit is tagged
   `v<version>`.
5. Publish the release under its IRIs: copy `pizza.owl` to `docs/pizza.owl`, and
   `releases/<version>/pizza.owl` to `docs/pizza/<version>` - with no extension, as in the version
   IRI. This site serves them at those addresses.
6. **OntoBoard > Build and release > Documentation...**, *Write it to* `docs/ontology`, *Include the
   WebVowl diagram* ticked.
7. Commit that, and push the commits and the tag: `git push --follow-tags`. This site is
   republished from `main`.

From a terminal, the build alone is `sh run.sh make prepare_release` in `src/ontology`, which needs
Docker.

A version IRI cannot be taken back once somebody has imported it, so a version that has been
released is not released again: the next release gets the next number.
