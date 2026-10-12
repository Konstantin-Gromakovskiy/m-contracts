using Http;

namespace PlaygroundService.DemoItems;

@pattern("[a-z-]+")
scalar DemoItemLabel extends string;

@doc("Состояние демонстрационной сущности.")
enum DemoItemStatus {
  draft: "draft",
  published: "published",
  archived: "archived",
}

@summary("Демонстрационная сущность")
@doc("""
Модель показывает обязательные, optional и nullable-поля, enum, массивы,
форматы, ограничения и пример данных.
""")
model DemoItem {
  @doc("Уникальный идентификатор элемента.")
  @format("uuid")
  id: string;

  @doc("Название: от 3 до 80 символов.")
  @minLength(3)
  @maxLength(80)
  name: string;

  @doc("Текущее состояние.")
  status: DemoItemStatus;

  @doc("Приоритет от 1 до 5.")
  @minValue(1)
  @maxValue(5)
  priority: int32;

  @doc("Метки из строчных латинских букв и дефисов.")
  @minItems(1)
  labels: DemoItemLabel[];

  @doc("Время публикации. null означает, что элемент ещё не опубликован.")
  publishedAt: utcDateTime | null;

  @doc("Необязательное пояснение для команды.")
  @maxLength(280)
  note?: string | null;
}

@doc("Данные для создания элемента.")
@example(#{
  name: "Team onboarding",
  priority: 3,
  labels: #["internal", "guide"],
  note: "Показываемый в Scalar пример тела запроса.",
})
model CreateDemoItemRequest {
  @doc("Название: от 3 до 80 символов.")
  @minLength(3)
  @maxLength(80)
  name: string;

  @doc("Приоритет. Значение по умолчанию: 3.")
  @minValue(1)
  @maxValue(5)
  priority: int32 = 3;

  @doc("Метки элемента.")
  @minItems(1)
  labels: DemoItemLabel[];

  @doc("Необязательное пояснение.")
  @maxLength(280)
  note?: string | null;
}

@doc("Страница элементов с метаданными пагинации.")
model DemoItemPage {
  items: DemoItem[];
  @minValue(0)
  total: int32;
}

@error
@doc("Стандартизированная ошибка валидации или обработки запроса.")
model ProblemDetails {
  @statusCode statusCode: 400 | 404;
  @doc("Краткое описание ошибки.")
  title: string;
  @doc("Подробное объяснение для клиента.")
  detail: string;
  @doc("Стабильный машинно-читаемый код ошибки.")
  code: string;
}

model GetDemoItemResponse {
  @statusCode statusCode: 200;
  @header contentType: "application/json";
  @body body: DemoItem;
}

model CreateDemoItemResponse {
  @statusCode statusCode: 201;
  @header location: string;
  @body body: DemoItem;
}

model ListDemoItemsResponse {
  @statusCode statusCode: 200;
  @body body: DemoItemPage;
}
