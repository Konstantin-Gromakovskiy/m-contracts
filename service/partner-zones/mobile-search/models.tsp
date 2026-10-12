import "../../common/primitives.tsp";
import "../bases/models.tsp";

using Http;

namespace PartnerZonesService.MobileSearch;

@doc("Группа фильтров особенностей для мобильного поиска.")
model FeatureTypeFilter {
  @doc("Идентификатор группы фильтров.")
  typeId: Primitives.Uuid;

  @doc("Идентификаторы фильтров группы.")
  featureIds?: Primitives.Uuid[] | null;

  @doc("Режим сопоставления особенностей: `true` — достаточно одной выбранной особенности (логическое «ИЛИ»), `false` — требуются все выбранные особенности (логическое «И»).")
  atLeastOneFeature: boolean;
}

@doc("Общие параметры мобильного поиска объектов и комнат по карте.")
model MapMobileQueryBase {
  @doc("Идентификаторы сфер деятельности.")
  spheres: Primitives.Uuid[];

  @doc("Идентификаторы городов.")
  cityIds: Primitives.Uuid[];

  @doc("Группы фильтров особенностей.")
  featureTypes: FeatureTypeFilter[];

  @doc("Минимальная стоимость.")
  priceMin?: float64 | null;

  @doc("Максимальная стоимость.")
  priceMax?: float64 | null;

  @doc("Минимальная площадь.")
  squareMin?: float64 | null;

  @doc("Максимальная площадь.")
  squareMax?: float64 | null;

  @doc("Строка поиска.")
  searchLine: string;

  @doc("Признак поиска только свободных комнат.")
  isFree?: boolean | null;

  @doc("Признак доступности предоплаты.")
  isPrepay?: boolean | null;

  @doc("Признак бронирования по запросу.")
  onRequest?: boolean | null;

  @doc("Признак возможности оплаты баллами.")
  isPayPoints?: boolean | null;

  @doc("Признак поиска только избранных объектов.")
  favouriteOnly?: boolean | null;
}

@doc("Параметры мобильного поиска с периодом, опцией и количеством человек.")
model MapMobileQueryWithAvailabilityParameters {
  ...MapMobileQueryBase;

  @doc("Начало периода поиска.")
  dateFrom: utcDateTime | null;

  @doc("Окончание периода поиска.")
  dateTo: utcDateTime | null;

  @doc("Идентификатор опции.")
  optionId: Primitives.Uuid | null;

  @doc("Количество человек.")
  range?: int32 | null;
}

@doc("Параметры мобильного поиска без периода, опции и количества человек.")
model MapMobileQueryWithoutAvailabilityParameters {
  ...MapMobileQueryBase;
}

@summary("Параметры мобильного поиска по карте")
@doc("""
Допустимы две формы запроса: с одновременной передачей полей
`dateFrom`, `dateTo`, `optionId`, при этом поле `range` опционально,
или без всех четырёх полей.
""")
union MapMobileQuery {
  MapMobileQueryWithAvailabilityParameters,
  MapMobileQueryWithoutAvailabilityParameters,
}

@doc("Данные результата мобильного поиска по карте.")
model MapMobileResponseBody {
  @doc("Объекты, соответствующие условиям поиска.")
  bases: Bases.MapMobileBaseResult[];
}

@doc("Успешный ответ мобильного поиска по карте.")
model MapMobileResponse {
  @statusCode statusCode: 200;
  @body body: MapMobileResponseBody;
}
