using Http;
using OpenAPI;

namespace PlaygroundService.DemoItems;

@tag("Demo items")
@doc("Операции с демонстрационной сущностью.")
interface DemoItems {
  @doc("Показывает path-параметр, HTTP-ответ и ошибку `404`. Это пример использования маршрута без декоратора @summary, здесь маршрут отображается прям в названии")
  @returnsDoc("Возвращает демонстрационный элемент.")
  @operationId("GetDemoItem")
  @get
  @route("/demo-items/{id}")
  getDemoItem(
    @doc("UUID элемента.")
    @path id: string,
  ): GetDemoItemResponse | ProblemDetails;

  @summary("Получить страницу элементов")
  @doc("Показывает query-параметры с ограничениями и значениями по умолчанию. Это пример использования маршрута с декоратором @summary, в названии отображается то, что написано в @summary.")
  @extension("x-demo-purpose", "Показывает добавление OpenAPI extension.")
  @operationId("ListDemoItems")
  @get
  @externalDocs("https://exemple.com/", "🔺Пример сторонней документации для расширения описания ендпоинта")
  @route("/demo-items")
  listDemoItems(
    @doc("Фильтр по состоянию.")
    @query status?: DemoItemStatus,
    @doc("Размер страницы. Значение по умолчанию: 20.")
    @query @minValue(1) @maxValue(100) limit: int32 = 20,
    @doc("Количество пропускаемых элементов.")
    @query @minValue(0) offset: int32 = 0,
    @doc("Необязательный идентификатор запроса для трассировки.")
    @header("x-request-id") requestId?: string,
  ): ListDemoItemsResponse;

  @summary("Создать демонстрационный элемент")
  @doc("Показывает JSON-тело запроса, пример модели, ответ `201` и заголовок `Location`.")
  @externalDocs("https://typespec.io/docs/language-basics/decorators/", "Декораторы TypeSpec")
  @operationId("CreateDemoItem")
  @post
  @route("/demo-items")
  createDemoItem(@body body: CreateDemoItemRequest): CreateDemoItemResponse | ProblemDetails;

  @doc("Устаревший маршрут сохранён только для демонстрации. Используйте `getDemoItem`.")
  @operationId("GetDemoItemLegacy")
  @get
  @route("/legacy/demo-items/{id}")
  getDemoItemLegacy(@path id: string): GetDemoItemResponse | ProblemDetails;

  #deprecated "Используйте другую ручку"
  @doc("Это пример устаревшего маршрута, он помечен как #deprecated,")
  @get
  @route("/deprecated-route")
  getDeprecatedRoute(@path id:string): { @statusCode statusCode: 200 }
}
