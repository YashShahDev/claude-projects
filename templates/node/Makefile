.PHONY: build test lint clean install

install:
	npm install

build: install
	npm run build --if-present

test: install
	npm test --if-present

lint: install
	npm run lint --if-present

clean:
	rm -rf node_modules dist build
