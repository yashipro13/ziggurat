.PHONY: all

TOPIC_JSON="json-log"
TOPIC_PLAIN_TEXT="plain-text-log"


docker.start-kafka:
	docker-compose down
	docker-compose up -d
	sleep 10
	docker exec -it ziggurat_go_kafka /opt/bitnami/kafka/bin/kafka-topics.sh --create --topic $(TOPIC_JSON) --partitions 3 --replication-factor 1 --zookeeper ziggurat_go_zookeeper
	docker exec -it ziggurat_go_kafka /opt/bitnami/kafka/bin/kafka-topics.sh --create --topic $(TOPIC_PLAIN_TEXT) --partitions 3 --replication-factor 1 --zookeeper ziggurat_go_zookeeper
	@echo 'Please run `go run main.go` in a new tab or terminal'
	sleep 5

docker.start-metrics:
	docker-compose -f docker-compose-metrics.yml down
	docker-compose -f docker-compose-metrics.yml up -d
	sleep 10

app.start:
	go build
	./ziggurat-go --config=./config/config.sample.yaml

app.test:
	go test -count 1 -v `go list ./pkg/ziggurat/* | grep -v basic | grep -v "ziggurat/z"`

app.start-race:
	go build -race
	./ziggurat-go --config=./config/config.sample.yaml

docker.cleanup:
	docker-compose down
	docker-compose rm
	docker-compose -f docker-compose-metrics.yml down
	docker-compose -f docker-compose-metrics.yml rm

kafka.produce:
	./scripts/produce_messages

pkg.release:
	./scripts/release.sh ${VERSION}

app.test-coverage:
	go test -count 1 -p 2 ./zig -coverprofile cp.out
	go tool cover -html=cp.out
