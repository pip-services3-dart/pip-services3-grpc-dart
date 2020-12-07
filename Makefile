.PHONY: test generate gendoc docview analyze format genproto

test:
	@pub run test ./test --concurrency=1

generate:
	@pub run build_runner build

gendoc:
	@dartdoc --no-auto-include-dependencies --no-include-source --show-progress --output docs

docview:
	@dhttpd --path docs

analyze:
	@dartanalyzer .

format:
	@dartfmt -w lib test

genproto:
	@protoc -I lib/src/protos/ lib/src/protos/commandable.proto --dart_out=grpc:lib/src/generated
	@protoc -I test/protos/ test/protos/dummies.proto --dart_out=grpc:test/generated
