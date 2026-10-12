using Http;
using OpenAPI;

@service(#{ title: "Discounts Service" })
@info(#{ version: "1.0.0" })
@summary("Сервис для управления акциями и промокодами")
@tagMetadata("Promocodes", #{ description: "Операции получения промокодов." })
@tagMetadata("Discounts", #{ description: "Операции получения акций." })
@route("/rpc/DiscountsService")
@doc("""
  Сервис скидок. Включает операции получения акций и промокодов партнёрской зоны.
  """)
namespace DiscountsService;
