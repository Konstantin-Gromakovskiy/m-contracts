using Http;
using OpenAPI;

@service(#{
  title: "TypeSpec Playground",
})
@info(#{ version: "1.0.0" })
@summary("Учебный API для знакомства с TypeSpec и OpenAPI")
@doc("""
Этот сервис демонстрирует, как TypeSpec превращает типы, HTTP-декораторы
и документацию в спецификацию OpenAPI, отображаемую в Scalar.

🔺 Здесь можно посмотреть как устроен код, поэкспериментировать с возможностями typeSpec и Scalar
""")
@server("https://api.example.test/playground", "Демонстрационный сервер")
@tagMetadata("Demo items", #{
  description: """
    Примеры операций, параметров, ответов, ошибок, ограничений полей
    и документации в TypeSpec. [🔗 Пример ссылки  на доку](https://typespec.io/docs/)
  """,
  externalDocs: #{
    url: "https://typespec.io/docs/",
    description: "Документация TypeSpec",
  },
})
namespace PlaygroundService;
