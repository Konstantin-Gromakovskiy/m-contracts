import "./models.tsp";

using Http;
using OpenAPI;

namespace DiscountsService.Promocodes;

@tag("Promocodes")
interface Promocodes {
  @doc("Получение промокодов")
  @post
  @route("/GetPromocodes")
  @operationId("GetPromocodes")
  GetPromocodes(): GetPromocodesResponse;
}
