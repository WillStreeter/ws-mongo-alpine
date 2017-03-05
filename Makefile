
DB_USER = $(shell echo `grep "DB_USER=" ./db.config.env | cut -d'=' -f1- `)
DB_PASSWORD = $(shell echo `grep "DB_PASSWORD=" ./db.config.env | cut -d'=' -f1- `)
DB_ROLE = $(shell echo `grep "DB_ROLE=" ./db.config.env | cut -d'=' -f1- `)
DB_STORAGE_ENGINE = $(shell echo `grep "DB_STORAGE_ENGINE=" ./db.config.env | cut -d'=' -f1- `)
DB_JOURNALING = $(shell echo `grep "DB_JOURNALING=" ./db.config.env | cut -d'=' -f1- `)
DB_MOUNTPOINT = $(shell echo `grep "DB_MOUNTPOINT=" ./db.config.env  | cut -d'=' -f1- `)
MONGODB_VERSION = $(shell echo `grep "MONGODB_VERSION=" ./db.config.env | cut -d'=' -f1- `)
MONGODB_PORT = $(shell echo `grep "MONGODB_PORT=" ./db.config.env | cut -d'=' -f1- `)

TAG = $(shell echo `grep "TAG=" ./hub.config.env | sed 's/.*=//'`)
VERSION = $(shell echo `grep "VERSION=" ./hub.config.env | sed 's/.*=//'`)

all:
	@echo About $(MONGODB_VERSION)

build:
	docker build -t  ws-mongo-alpine --build-arg $(DB_USER) --build-arg $(DB_PASSWORD) --build-arg $(DB_ROLE)  --build-arg $(DB_STORAGE_ENGINE)  --build-arg $(DB_JOURNALING) --build-arg $(DB_MOUNTPOINT) --build-arg $(MONGODB_VERSION) --build-arg $(MONGODB_PORT)  .

tag-it:
	docker tag $(TAG) willsonic/ws-mongo-alpine:$(VERSION)


hub-push:
	docker push willsonic/ws-mongo-alpine
