# Go parameters
GOCMD=CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go
GOTEST=$(GOCMD) test
GOBUILD=$(GOCMD) build

all: build

build:
	rm -rf target/
	mkdir -p target/config
	cp cmd/discovery/discovery-example.toml target/config/discovery.toml
	cp cmd/discovery/scheduler-example.json target/config/scheduler.json
	$(GOBUILD) -o target/discovery cmd/discovery/main.go

test:
	$(GOTEST) -v ./...

clean:
	rm -rf target/

