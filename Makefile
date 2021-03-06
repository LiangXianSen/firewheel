GO=go

SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

project = github.com/LiangXianSen/firewheel
packages := $(shell go list ./...|grep -v /vendor/)

.PHONY: check test lint

test: check
	@$(GO) test -race $(packages) -v -coverprofile=coverage.txt -covermode=atomic
	@$(GO) tool cover -func=coverage.txt

check:
	@$(GO) vet -composites=false $(packages)

lint:
	@golint -set_exit_status $(packages)

lint-runner:
	@golangci-lint run ./...

doc:
	@godoc -http=localhost:6060 -play

clean:
	@rm $(TARGET)
