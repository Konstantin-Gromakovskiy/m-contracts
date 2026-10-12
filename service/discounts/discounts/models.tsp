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

@doc("Успешный ответ с получением списка акций.")
model GetDiscountsResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<DiscountDto[]>;
}
