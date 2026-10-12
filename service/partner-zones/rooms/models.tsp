import "../../common/primitives.tsp";
import "../../common/files.tsp";

namespace PartnerZonesService.Rooms;

@doc("Диапазон стоимости комнаты. Возвращается при поиске без полей `dateFrom` и `dateTo`.")
model RoomPriceRangeDto {
  @doc("Минимальная стоимость комнаты.")
  priceMin: float64;

  @doc("Максимальная стоимость комнаты.")
  priceMax: float64;
}

@doc("Фиксированная стоимость комнаты с ценой до применения скидки. Возвращается при поиске с переданными полями `dateFrom` и `dateTo`.")
model RoomFixedPriceDto {
  @doc("Стоимость комнаты.")
  price: float64;

  @doc("Стоимость комнаты до применения скидки.")
  priceBeforeDiscount: float64;
}

@doc("Цены комнаты: `priceMin` и `priceMax` возвращаются при поиске без `dateFrom`/`dateTo`; `price` и `priceBeforeDiscount` — при поиске с переданными `dateFrom`/`dateTo`.")
union RoomPricesDto {
  range: RoomPriceRangeDto,
  fixed: RoomFixedPriceDto,
}

@doc("Комната в результате поиска .")
// TODO: MapMobileRoomResult должен наследоваться от RoomDto после добавления базовой модели.
model MapMobileRoomResult {
  @doc("Идентификатор комнаты.")
  id: Primitives.Uuid;

  @doc("Название комнаты.")
  name: string;

  @doc("Файлы комнаты.")
  files: Files.FileDto[];

  @doc("Максимальный процент оплаты баллами.")
  maxPointsPcPay: float64;

  @doc("Площадь комнаты.")
  square: float64;

  @doc("Цены комнаты.")
  prices: RoomPricesDto;
}
