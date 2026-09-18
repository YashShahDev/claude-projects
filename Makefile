PROJECTS := $(patsubst projects/%/Makefile,%,$(wildcard projects/*/Makefile))

.PHONY: help list build test lint clean new

help:
	@echo "claude-projects monorepo"
	@echo ""
	@echo "  make list                                  List all projects"
	@echo "  make build [PROJECT=name]                  Build all projects, or one"
	@echo "  make test  [PROJECT=name]                  Test all projects, or one"
	@echo "  make lint  [PROJECT=name]                  Lint all projects, or one"
	@echo "  make clean [PROJECT=name]                  Clean all projects, or one"
	@echo "  make new PROJECT=name [LANG=generic|python|node|go|rust]   Scaffold a new project"

list:
	@if [ -z "$(PROJECTS)" ]; then \
		echo "No projects yet. Run 'make new PROJECT=<name>' to create one."; \
	else \
		for p in $(PROJECTS); do echo "$$p"; done; \
	fi

build test lint clean:
ifdef PROJECT
	@$(MAKE) --no-print-directory -C projects/$(PROJECT) $@
else
	@if [ -z "$(PROJECTS)" ]; then \
		echo "No projects to $@ yet. Run 'make new PROJECT=<name>' first."; \
	else \
		for p in $(PROJECTS); do \
			echo "==> $@ $$p"; \
			$(MAKE) --no-print-directory -C projects/$$p $@ || exit 1; \
		done; \
	fi
endif

new:
ifndef PROJECT
	$(error Usage: make new PROJECT=<name> [LANG=generic|python|node|go|rust])
endif
	@./scripts/new_project.sh "$(PROJECT)" "$(if $(LANG),$(LANG),generic)"
