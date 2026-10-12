namespace Responses;

@doc("Параметры для подстановки в текст сообщения пользователю.")
model MessageParams {
  @doc("Первый параметр сообщения.")
  a?: string;
  @doc("Второй параметр сообщения.")
  b?: string;
  @doc("Третий параметр сообщения.")
  c?: string;
  @doc("Четвертый параметр сообщения.")
  d?: string;
}

@doc("Сообщение результата операции.")
model ResponseMessage {
  @doc("Семизначный машинно-читаемый код сообщения.")
  @example(1010112)
  @minValue(1000000)
  @maxValue(4999999)
  code: uint32;
  @doc("Параметры для подстановки в текст сообщения.")
  params: MessageParams;
}

@doc("Метаданные результата операции.")
model ResponseMeta {
  @doc("Сообщение результата операции.")
  message: ResponseMessage;
}

@doc("Стандартная оболочка ответа приложения.")
model ApiResponse<T> {
  @doc("Данные ответа.")
  body: T;
  @doc("Метаданные ответа.")
  meta: ResponseMeta;
}
