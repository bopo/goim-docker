# Go parameters
GOCMD=CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go
GOTEST=$(GOCMD) test
GOBUILD=$(GOCMD) build

all: test build
build:
	rm -rf target/
	mkdir -p target

	cp cmd/comet/comet-example.toml target/comet.toml
	cp cmd/logic/logic-example.toml target/logic.toml
	cp cmd/job/job-example.toml target/job.toml
	
	$(GOBUILD) -o target/comet cmd/comet/main.go
	$(GOBUILD) -o target/logic cmd/logic/main.go
	$(GOBUILD) -o target/job cmd/job/main.go

test:
	$(GOTEST) -v ./...

clean:
	rm -rf target/

