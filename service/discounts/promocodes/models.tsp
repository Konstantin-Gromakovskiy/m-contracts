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

  @doc("Область применения и значение скидки")
  application: DiscountApplication;

  @doc("Ограничения на количество применений")
  limits: DiscountLimits;

  @doc("Условия активации")
  conditions: DiscountConditions;

  @doc("Клиенты, которым разрешён промокод")
  audience: DiscountAudience;

  @doc("Статистика использования")
  usage: DiscountUsage;
}

@doc("""
  Параметры получения промокодов по фильтрам. Фильтры объединяются через И.
  Пустой массив означает, что фильтр не применяется.
  """)
@example(#{
  ids: #["2f6a1c7e-5b1d-4c3a-9a53-0d6c4f1f9a10"],
  clientIds: #["7b9e3a52-1c4d-4e8f-8a6b-3d2f5c9e1a47"],
})
model PromocodesFilterParams {
  @doc("Id промокодов. При пустом массиве возвращаются все промокоды")
  ids: Primitives.Uuid[];

  @doc("""
    Id клиентов: возвращаются промокоды, доступные хотя бы одному из них, то есть промокоды
    без ограничения по аудитории (`audience.allowedClientIds` пуст) и промокоды, где клиент
    указан в `audience.allowedClientIds`. При пустом массиве фильтр не применяется
    """)
  clientIds: Primitives.Uuid[];
}

@doc("Успешный ответ с получением списка промокодов.")
model GetPromocodesResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PromocodeDto[]>;
}
