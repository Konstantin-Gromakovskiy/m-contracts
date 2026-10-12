import "../../common/primitives.tsp";
import "../../common/files.tsp";
import "../rooms/models.tsp";

namespace PartnerZonesService.Bases;

@doc("Формат работы объекта.")
enum WorkingFormat {
  @doc("Бронирование по актуальному расписанию.")
  Online: 0,

  @doc("Бронирование по заявке.")
  OnRequest: 1,
}

@doc("Географические координаты объекта.")
model Coordinates {
  @doc("Широта.")
  latitude: float64;

  @doc("Долгота.")
  longitude: float64;
}

@doc("Станция метро рядом с объектом.")
model SubwayStationDto {
  @doc("Название станции метро.")
  name: string;

  @doc("Цвет линии метро.")
  color: Primitives.HexColor;
}

@doc("Сводная информация об оценках объекта.")
model ReviewsAverageDto {
  @doc("Средняя оценка по отзывам.")
  average: float64;

  @doc("Количество отзывов.")
  count: int32;
}

@doc("Объект в результате поиска по карте.")
// TODO: MapMobileBaseResult должен наследоваться от BaseDto после добавления базовой модели.
model MapMobileBaseResult {
  @doc("Идентификатор объекта.")
  id: Primitives.Uuid;

  @doc("Название объекта.")
  name: string;

  @doc("Адрес объекта.")
  address: string;

  @doc("Публичное название партнёрской зоны.")
  partnerZonePublicName: string;

  @doc("Процент предоплаты.")
  prepayPercent: float64;

  @doc("Общее количество комнат объекта.")
  totalRoomCount: int32;

  @doc("Файлы объекта.")
  files: Files.FileDto[];

  @doc("URL видеоролика с маршрутом до объекта.")
  routeVideoUrl: string;

  @doc("Комнаты объекта.")
  rooms: Rooms.MapMobileRoomResult[];

  @doc("Географические координаты объекта.")
  coordinates: Coordinates;

  @doc("Станции метро рядом с объектом.")
  subways: SubwayStationDto[];

  @doc("Средняя оценка и количество отзывов.")
  reviewsAverage: ReviewsAverageDto;

  @doc("Количество комнат объекта, соответствующих условиям поиска.")
  roomsCount: int32;

  @doc("Формат работы объекта.")
  workingFormat: WorkingFormat;
}
