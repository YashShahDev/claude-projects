.PHONY: build test lint clean venv

venv:
	python3 -m venv .venv

build: venv
	.venv/bin/pip install -e ".[dev]"

test: venv
	.venv/bin/pytest

lint: venv
	.venv/bin/ruff check .

clean:
	rm -rf .venv build dist *.egg-info **/__pycache__
