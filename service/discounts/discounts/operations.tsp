import "./models.tsp";

using Http;
using OpenAPI;

namespace DiscountsService.Discounts;

@tag("Discounts")
interface Discounts {
  @doc("Получение акций")
  @post
  @route("/GetDiscounts")
  @operationId("GetDiscounts")
  GetDiscounts(): GetDiscountsResponse;
}
