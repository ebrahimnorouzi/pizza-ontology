# Custom targets for pizza.
# This file is never overwritten - put your own rules here.

# --- OntoBoard: questions (change nothing down to the line that ends them) ---
# Every .rq file in src/sparql is a question this ontology has to answer: a query
# whose every row is something that breaks it. `make test` asks them of the
# ontology WITH its imports and fails on any row. ODK's own checks (sparql_test,
# the *-violation.sparql files the configuration lists) read the edit file without
# its imports, where a question about an imported term has no answer.
# OntoBoard wrote these lines - Check and test > Write a test from a question...
# adds a question - and runs them itself where there is no container, but only
# as they are written here.
QUESTIONS = $(wildcard ../sparql/*.rq)

.PHONY: question_test
question_test:
ifneq ($(strip $(QUESTIONS)),)
question_test: $(EDIT_PREPROCESSED) | $(REPORTDIR)
	$(ROBOT) merge --input $(EDIT_PREPROCESSED) verify --queries $(QUESTIONS) -O $(REPORTDIR)
endif

test: question_test
# --- OntoBoard: end of questions ---
