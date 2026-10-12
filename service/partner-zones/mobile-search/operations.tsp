using Http;
using OpenAPI;

namespace PartnerZonesService.MobileSearch;

@tag("Mobile Search")
@doc("Методы поиска объектов и комнат для мобильного приложения.")
interface MobileSearch {
  @summary("Поиск объектов и комнат по карте")
  @doc("Возвращает объекты и комнаты, соответствующие параметрам мобильного поиска по карте.")
  @externalDocs(
    "https://wiki.yandex.ru/homepage/tech/api/api-3.0-novaja-versija-sistemy/metody-dlja-interfejjsov/mobilnoe-prilozhenie/poisk-po-sferam/poisk-komnat-i-tomu-podobnoe/poisk-po-karte/",
    "Документация MapMobile",
  )
  @post
  @route("/MapMobile")
  @operationId("MapMobile")
  MapMobile(
    @body body: MapMobileQuery,
  ): MapMobileResponse;
}
