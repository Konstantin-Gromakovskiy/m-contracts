import "./models.tsp";

using Http;
using OpenAPI;

namespace DiscountsService.Promocodes;

@tag("Promocodes")
interface Promocodes {
  @doc("Получение промокодов")
  @post
  @route("/GetPromocodesByFilter")
  @operationId("GetPromocodesByFilter")
  GetPromocodesByFilter(): GetPromocodesResponse;
}
