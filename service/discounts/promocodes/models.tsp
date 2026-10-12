import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../shared/models.tsp";

using Http;
using DiscountsService.Shared;

namespace DiscountsService.Promocodes;

@doc("Промокод. Скидка применяется, если указать код при создании заказа.")
model PromocodeDto {
  @doc("Идентификатор промокода")
  id: Primitives.Uuid;

  @doc("Идентификатор партнёрской зоны. `null` — сервисный промокод, действующий в любых партнёрских зонах.")
  partnerZoneId: Primitives.Uuid | null;

  @doc("Код промокода, уникален в системе")
  @example("SUMMER10")
  @maxLength(10)
  name: string;

  @doc("Описание промокода")
  @maxLength(255)
  description: string;

  @doc("Значение скидки")
  value: DiscountValue;

  @doc("Ограничения на количество применений")
  limits: DiscountLimits;

  @doc("Условия активации")
  conditions: DiscountConditions;

  @doc("Клиенты, которым разрешён промокод")
  audience: DiscountAudience;

  @doc("Статистика использования")
  usage: DiscountUsage;
}

@doc("Успешный ответ с получением списка промокодов.")
model GetPromocodesResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PromocodeDto[]>;
}
