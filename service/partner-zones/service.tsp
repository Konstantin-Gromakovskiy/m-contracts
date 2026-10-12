using Http;
using OpenAPI;

@service(#{ title: "Partner Zones Service" })
@tagMetadata("Mobile Search", #{
  description: "Методы поиска объектов и комнат для мобильного приложения.",
})
@tagMetadata("Advertising Places", #{
  description: "Операции получения мест размещения рекламы.",
})
@tagMetadata("Advertising Tariffs", #{
  description: "Операции создания, обновления и получения рекламных тарифов.",
})
@tagMetadata("Advertising Banners", #{
  description: "Операции создания и обновления рекламных баннеров.",
})
@route("/rpc/PartnerZonesService")
namespace PartnerZonesService;


