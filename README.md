# API-контракты

В этой директории находятся API-контракты сервисов Musbooking. Контракты описываются на [TypeSpec](https://typespec.io/) и компилируются в спецификацию OpenAPI 3.1.

## Структура

- `main.tsp` - корневая точка входа TypeSpec.
- `service/` - контракты, сгруппированные по сервисам и доменам.
- `tspconfig.yaml` - настройка эмиттера OpenAPI 3.1.
- `tsp-output/schema/openapi.<service>.json` - сгенерированные OpenAPI-спецификации сервисов. Файлы не хранятся в Git.

## Локальная компиляция

Требуется Node.js 24 или новее.

```bash
cd contracts
npm ci
npm run compile
```

Сгенерированные спецификации появятся в `tsp-output/schema/`.

## Разработка

Для разработки с автоматической пересборкой TypeSpec и обновлением Scalar запустите:

```bash
cd contracts
npm run dev
```

Scalar откроется на http://localhost:8081 и будет перезагружаться после изменения TypeSpec-файлов. Процесс работает, пока его не остановить сочетанием `Ctrl+C`.

## Примеры ответов

Используйте отдельный `examples.tsp` с `const` и `@opExample` только когда автоматического примера недостаточно или нужен конкретный пример ответа. Для ответа с массивом объектов `@opExample` должен содержать полный `returnType`, включая HTTP-статус, тело ответа и метаданные.

## TypeSpec Playground

`PlaygroundService` входит в основной `main.tsp` и генерируется при обычном `npm run compile`. Это изолированный учебный сервис с группой `Demo items`: он не является контрактом продуктового API.

В его контракте приведены примеры `@service`, `@server`, `@tag`, `@tagMetadata`, `@summary`, `@doc`, `@example`, `@operationId`, `@externalDocs`, HTTP-декораторов (`@get`, `@post`, `@path`, `@query`, `@header`, `@body`, `@statusCode`) и ограничений схемы (`@format`, `@minLength`, `@maxLength`, `@pattern`, `@minItems`, `@minValue`, `@maxValue`).

Откройте Scalar и выберите `TypeSpec Playground` в селекторе спецификаций, чтобы увидеть, как эти конструкции отражаются в OpenAPI.

## Scalar

Для запуска локального интерфейса Scalar выполните:

```bash
cd contracts
npm run preview
```

По умолчанию Scalar будет доступен по адресу http://localhost:8081. В селекторе Scalar доступны все сервисы основной сборки, включая `TypeSpec Playground`. Команда выполняет одну компиляцию и запускает статический сервер без автоматической пересборки; для разработки используйте `npm run dev`.

При необходимости укажите другой порт:

```bash
SCALAR_PORT=8082 npm run preview
```

## Запуск через Docker

Проект можно запустить в Docker: образ скомпилирует TypeSpec и отдаст сгенерированную спецификацию через [Scalar](https://scalar.com/) (nginx со статикой). Это тот же образ, что деплоится в кластер.

```bash
cd contracts
npm run docker
```

Откройте http://localhost:8080 в браузере.

При необходимости укажите другой порт:

```bash
DOCKER_PORT=8082 npm run docker
```
