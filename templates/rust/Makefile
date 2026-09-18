.PHONY: build test lint clean

build:
	cargo build

test:
	cargo test

lint:
	cargo fmt --check
	cargo clippy --all-targets -- -D warnings

clean:
	cargo clean
