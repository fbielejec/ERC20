.PHONY: deps lint test

deps:
	forge install
	pnpm install

lint:
	pnpm lint

test:
	forge test -vvv
