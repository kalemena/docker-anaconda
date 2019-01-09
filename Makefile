
VERSION := 3-2018.12

all: build start

build:
	@echo "+++ Building docker image +++"
	docker build --build-arg VERSION=$(VERSION) -t kalemena/anaconda:$(VERSION) .

start:
	@echo "+++ Environment starting ... +++"
	docker-compose up -d
	@echo "+++ Environment started +++"

stop:
	@echo "+++ Environment stopping ... +++"
	docker-compose stop
	@echo "+++ Environment stopped +++"

clean:
	@echo "+++ Environment cleaning ... +++"
	docker-compose down
	@echo "+++ Environment cleaned +++"
