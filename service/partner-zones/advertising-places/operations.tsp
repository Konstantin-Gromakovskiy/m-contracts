using Http;
using OpenAPI;

namespace PartnerZonesService.AdvertisingPlaces;

@tag("Advertising Places")
@doc("Операции с местами размещения рекламы.")
interface AdvertisingPlaces {
  @summary("Получить места размещения рекламы")
  @doc("Возвращает список доступных мест размещения рекламы.")
  @post
  @route("/GetAdvertisingPlaces")
  @operationId("GetAdvertisingPlaces")
  GetAdvertisingPlaces(
    @body body: GetAdvertisingPlacesCommand,
  ): GetAdvertisingPlacesResponse;
}
