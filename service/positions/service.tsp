using Http;
using OpenAPI;

@service(#{ title: "Positions Service" })
@info(#{ version: "1.0.0" })
@summary("Сервис для управления позициями")
@tagMetadata("Positions", #{
  description: "Операции получения и управления позициями.",
})
@route("/rpc/PositionsService")
@doc("""
  Сервис позиций. Включает операции получения позиций по фильтрам.
  """)
namespace PositionsService;
