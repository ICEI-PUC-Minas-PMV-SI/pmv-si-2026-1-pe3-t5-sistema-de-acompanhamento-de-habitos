.PHONY: run run-debug analyze format clean test gen gen-watch build-apk build-aab install-release

run:
	flutter run --release

run-debug:
	flutter run

analyze:
	flutter analyze

test:
	flutter test

format:
	dart format .

clean:
	flutter clean && flutter pub get

gen:
	dart run build_runner build --delete-conflicting-outputs

gen-watch:
	dart run build_runner watch --delete-conflicting-outputs

build-apk:
	flutter build apk --release

build-aab:
	flutter build appbundle

install-release:
	flutter install --release
