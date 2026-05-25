.PHONY: run run-debug analyze format clean test gen gen-watch build-apk build-aab install-release

# Quando existir .env.json (gitignored), injeta as variáveis via dart-define.
# Mantém compatibilidade com quem ainda não copiou o .env.example.json.
ENV_FILE := $(wildcard .env.json)
DART_DEFINE := $(if $(ENV_FILE),--dart-define-from-file=.env.json,)

run:
	flutter run --release $(DART_DEFINE)

run-debug:
	flutter run $(DART_DEFINE)

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
	flutter build apk --release $(DART_DEFINE)

build-aab:
	flutter build appbundle $(DART_DEFINE)

install-release:
	flutter install --release
