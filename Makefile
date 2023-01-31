.PHONY: test

test:
	@./test/bats/bin/bats test/url.bats
