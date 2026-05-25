# SAH — Sistema de Acompanhamento de Hábitos (mobile)

Flutter app local-only, com Hive como persistência. UI em pt/en/es, dark mode,
widget Android, integração opcional com webhook do Discord para audit logs.

## Setup

```bash
flutter pub get
```

### Variáveis de ambiente (opcional)

Configure integrações externas via `.env.json` na raiz do projeto. O Makefile
injeta automaticamente quando o arquivo existe:

```bash
cp .env.example.json .env.json
# Edite .env.json com suas chaves
```

| Chave | Onde é usada | Obrigatório |
|---|---|---|
| `SAH_DISCORD_WEBHOOK` | `DiscordLogger` espelha audit logs como embed no canal | Não — sem isso, o envio é desligado e o app loga só no Hive local |

## Rodar

```bash
make run          # release com hot start (rápido)
make run-debug    # debug com hot reload (desenvolvimento)
make analyze      # flutter analyze
make test         # flutter test (41 testes)
make build-apk    # gera build/app/outputs/flutter-apk/app-release.apk
make install-release  # instala o APK release no device conectado
```

## Credencial de teste (seed no primeiro boot)

| E-mail | Senha | Role |
|---|---|---|
| `eduardo@sah.app` | `senha123` | Owner / Admin |

Demais usuários são criados via `/signup`. O primeiro signup também vira admin
se o box de users estiver vazio.

## Smoke test manual

Veja [`docs/smoke_test.md`](docs/smoke_test.md) — checklist 1-pager para
validar os principais fluxos antes de cada release.
