import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../shared/models.tsp";

using Http;
using DiscountsService.Shared;

namespace DiscountsService.Discounts;

@doc("Акция. Скидка применяется автоматически ко всем заказам, подходящим под условия активации.")
model DiscountDto {
  @doc("Идентификатор акции")
  id: Primitives.Uuid;

  @doc("Идентификатор партнёрской зоны, в которой действует акция")
  partnerZoneId: Primitives.Uuid;

  @doc("Название акции")
  @example("Скидка выходного дня")
  @maxLength(50)
  name: string;

  @doc("Описание акции")
  @maxLength(255)
  description: string;

  @doc("Область применения и значение скидки")
  application: DiscountApplication;

  @doc("Ограничения на количество применений")
  limits: DiscountLimits;

  @doc("Условия активации")
  conditions: DiscountConditions;

  @doc("Статистика использования")
  usage: DiscountUsage;
}

@doc("""
  Параметры получения акций по фильтрам. Фильтры объединяются через И.
  Пустой массив означает, что фильтр не применяется.
  """)
@example(#{
  ids: #["2f6a1c7e-5b1d-4c3a-9a53-0d6c4f1f9a10"],
  roomIds: #["c1d2e3f4-0a1b-4c2d-8e3f-5a6b7c8d9e01"],
})
model DiscountsFilterParams {
  @doc("Id акций. При пустом массиве возвращаются все акции")
  ids: Primitives.Uuid[];

  @doc("""
    Id комнат: возвращаются акции, действующие хотя бы в одной из них, то есть акции
    без ограничения по комнатам (`conditions.roomIds` пуст) и акции, где комната
    указана в `conditions.roomIds`. При пустом массиве фильтр не применяется
    """)
  roomIds: Primitives.Uuid[];
}

@doc("Успешный ответ с получением списка акций.")
model GetDiscountsResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<DiscountDto[]>;
}
