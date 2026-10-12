import "../../common/primitives.tsp";
import "../../common/responses.tsp";
using Http;

namespace ClientsService.Points;


@doc("Причина начисления или списания баллов.")
enum PointReason {
  @doc("Регистрация клиента.")
  Registration: 0,
  @doc("Заполнение профиля.")
  ProfileFullFillment: 1,
  @doc("Приглашение клиента.")
  Invite: 2,
  @doc("Отзыв.")
  Review: 3,
  @doc("Продление тарифа.")
  TariffExtention: 4,
  @doc("Бронирование.")
  Booking: 5,
  @doc("Оплата тарифа.")
  TariffPayment: 6,
  @doc("Оплата бронирования.")
  BookingPayment: 7,
  @doc("Ручное начисление баллов.")
  ManualAdd: 8,
  @doc("Ручное списание баллов.")
  ManualRemove: 9, 
}

@doc("Запись об операции с баллами клиента.")
model PointDto {
  @doc("Идентификатор операции с баллами.")
  id: Primitives.Uuid;

  @doc("Количество начисленных или списанных баллов.")
  amount: uint64;

  @doc("Причина начисления или списания баллов.")
  reason: PointReason;

  @doc("Идентификатор связанного заказа, если операция относится к заказу.")
  orderId?: Primitives.Uuid;

  @doc("Идентификатор связанной комнаты, если операция относится к комнате.")
  roomId?: Primitives.Uuid;

  @doc("Идентификатор клиента.")
  clientId: Primitives.Uuid;

  @doc("Идентификатор пользователя, создавшего операцию.")
  createdBy: Primitives.Uuid;

  @doc("Признак архивирования операции.")
  isArchived: boolean;

  @doc("Описание операции с баллами.")
  description: string;
}

@doc("Запрос на получение операций с баллами клиента.")
model GetPointsByClientServiceQuery {
  @doc("Идентификатор клиента.")
  clientId: Primitives.Uuid;
}

@doc("Данные об операциях с баллами клиента.")
model GetPointsByClientServiceResponce {
  @doc("Операции с баллами клиента.")
  pointDtos?: PointDto[];
}

@doc("Успешный ответ с операциями по баллам клиента.")
model GetPointsByClientServiceResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<GetPointsByClientServiceResponce>;
}

@doc("Команда обновления записи об операции с баллами клиента.")
model UpdatePointServiceCommand is TypeSpec.OmitProperties<
  PointDto,
  "orderId" | "roomId" | "clientId" | "createdBy"
>;

@doc("Успешный ответ с обновлённой записью об операции с баллами клиента.")
model UpdatePointServiceResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PointDto>;
}
