.PHONY: deps lint test

deps:
	forge install

format:
	forge fmt

test:
	forge test -vv
