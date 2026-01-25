.PHONY: deps format compile test

deps:
	forge install

format:
	forge fmt

compile:
	forge compile

test:
	forge test -vv
