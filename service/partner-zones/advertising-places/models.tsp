import "../../common/primitives.tsp";

using Http;

namespace PartnerZonesService.AdvertisingPlaces;

@doc("Пустые входные данные для получения мест размещения рекламы.")
model GetAdvertisingPlacesCommand {}

@doc("Место размещения рекламы.")
model AdvertisingPlaceDto {
  @doc("Идентификатор места размещения рекламы.")
  id: Primitives.Uuid;

  @doc("Идентификатор источника места размещения рекламы.")
  sourceId: Primitives.Uuid;

  @doc("Отображаемое название места размещения рекламы.")
  name: string;

  @doc("Внутреннее название места размещения рекламы.")
  internalName: string;
}

@doc("Данные ответа со списком мест размещения рекламы.")
@example(#{
  places: #[
    #{
      id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      sourceId: "8c5c4c83-23a2-4f0e-b8b5-76d2373c37f4",
      name: "string",
      internalName: "string",
    },
  ],
})
model GetAdvertisingPlacesResponseBody {
  @doc("Места размещения рекламы.")
  places: AdvertisingPlaceDto[];
}

@doc("Успешный ответ со списком мест размещения рекламы.")
model GetAdvertisingPlacesResponse {
  @statusCode statusCode: 200;
  @body body: GetAdvertisingPlacesResponseBody;
}
