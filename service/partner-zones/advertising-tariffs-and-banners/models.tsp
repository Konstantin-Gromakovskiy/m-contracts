import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../advertising-places/models.tsp";

using Http;

namespace PartnerZonesService.AdvertisingTariffsAndBanners;

@doc("Диапазон мест приоритета размещения рекламы.")
model AdvertisingPlacementPriorityRange {
  @doc("Начальное место приоритета.")
  from: int32;

  @doc("Конечное место приоритета.")
  to: int32;
}

@doc("Полное представление условия размещения рекламы.")
model AdvertisingPlacementConditionDto {
  @doc("Идентификатор условия размещения рекламы.")
  id: Primitives.Uuid;

  @doc("Название условия размещения рекламы.")
  name: string;

  @doc("Стоимость размещения рекламы.")
  cost: decimal128;

  @doc("Признак архивности условия размещения рекламы.")
  isArchived: boolean;

  @doc("Диапазон мест приоритета размещения рекламы.")
  priorityRange: AdvertisingPlacementPriorityRange;

  @doc("Идентификатор места размещения рекламы.")
  placeId: PartnerZonesService.AdvertisingPlaces.AdvertisingPlaceDto.id | null;
}

@doc("Команда создания условия размещения рекламы. Идентификатор условия формируется системой.")
model CreateAdvertisingPlacementConditionCommand is TypeSpec.OmitProperties<AdvertisingPlacementConditionDto, "id">;

@doc("Успешный ответ с полным представлением созданного условия размещения рекламы.")
model CreateAdvertisingPlacementConditionResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingPlacementConditionDto>;
}

@doc("Команда обновления условия размещения рекламы. Требует идентификатор и все поля условия.")
model UpdateAdvertisingPlacementConditionCommand is AdvertisingPlacementConditionDto;

@doc("Успешный ответ с полным представлением обновлённого условия размещения рекламы.")
model UpdateAdvertisingPlacementConditionResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingPlacementConditionDto>;
}

@doc("Параметры получения условий размещения рекламы.")
model AdvertisingPlacementConditionsFilterParams {
  @doc("Признак включения архивных условий в результат: `true` — вернуть все условия, `false` — только неархивные.")
  includeArchived: boolean;
}

@doc("Успешный ответ с массивом условий размещения рекламы.")
model GetAdvertisingPlacementConditionsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingPlacementConditionDto[]>;
}

@doc("Тип расчётного периода рекламного тарифа.")
enum AdvertisingTariffPeriodType {
  @doc("Расчётный период задаётся в днях.")
  Day: 0,

  @doc("Расчётный период задаётся в месяцах.")
  Month: 1,
}

@doc("Условие размещения, включённое в рекламный тариф.")
model AdvertisingTariffPlacementConditionDto {
  @doc("Идентификатор условия размещения.")
  id: Primitives.Uuid;

  @doc("Название условия размещения.")
  name: string;

  @doc("Идентификатор одного рекламного места, на котором действует условие.")
  placeId: PartnerZonesService.AdvertisingPlaces.AdvertisingPlaceDto.id;

  @doc("Диапазон приоритетов рекламного объявления в списке баннеров.")
  priorityRange: AdvertisingPlacementPriorityRange;

  @doc("Стоимость размещения рекламы по условию.")
  cost: decimal128;
}

@doc("Поля рекламного тарифа, задаваемые при создании и обновлении.")
model AdvertisingTariffCommandData {
  @doc("Название рекламного тарифа.")
  name: string;

  @doc("Подробное описание рекламного тарифа.")
  description: string;

  @doc("Идентификаторы сфер деятельности, в которых доступны места размещения по тарифу.")
  sphereIds: Primitives.Uuid[];

  @doc("Идентификаторы городов, в которых доступны места размещения по тарифу.")
  cityIds: Primitives.Uuid[];

  @doc("Дата и время начала доступности тарифа для активации.")
  from: utcDateTime;

  @doc("Дата и время окончания доступности тарифа для активации.")
  to: utcDateTime;

  @doc("Общий лимит активаций тарифа по всем партнёрским зонам.")
  @minValue(1)
  activationCount: int32;

  @doc("Лимит активаций тарифа в рамках одной партнёрской зоны.")
  @minValue(1)
  partnerZoneActivationLimit: int32;

  @doc("Признак обязательности рекламного идентификатора `erId` при активации тарифа.")
  hasErId: boolean;

  @doc("Признак возможности активировать тариф только один раз для одного аккаунта.")
  onlyOne: boolean;

  @doc("Тип расчётного периода: день или месяц.")
  periodType: AdvertisingTariffPeriodType;

  @doc("Количество дней или месяцев в одном периоде. Для дней допускается значение до 365, для месяцев — до 12.")
  @minValue(1)
  @maxValue(365)
  periodValue: int32;

  @doc("Максимальное суммарное количество периодов, доступных для оплаты.")
  @minValue(1)
  payPeriodQuantity: int32;

  @doc("Скидка в процентах за каждый оплачиваемый период после первого.")
  @minValue(0)
  @maxValue(100)
  periodDiscount: decimal128;

  @doc("Идентификаторы условий размещения, включённых в рекламный тариф.")
  placementConditionIds: Primitives.Uuid[];

  @doc("Признак архивности рекламного тарифа.")
  isArchived: boolean;
}

@doc("Полное представление рекламного тарифа.")
model AdvertisingTariffDto {
  @doc("Идентификатор рекламного тарифа.")
  id: Primitives.Uuid;

  @doc("Название рекламного тарифа.")
  name: string;

  @doc("Подробное описание рекламного тарифа.")
  description: string;

  @doc("Идентификаторы сфер деятельности, в которых доступны места размещения по тарифу.")
  sphereIds: Primitives.Uuid[];

  @doc("Идентификаторы городов, в которых доступны места размещения по тарифу.")
  cityIds: Primitives.Uuid[];

  @doc("Дата и время начала доступности тарифа для активации.")
  from: utcDateTime;

  @doc("Дата и время окончания доступности тарифа для активации.")
  to: utcDateTime;

  @doc("Общий лимит активаций тарифа по всем партнёрским зонам.")
  @minValue(1)
  activationCount: int32;

  @doc("Лимит активаций тарифа в рамках одной партнёрской зоны.")
  @minValue(1)
  partnerZoneActivationLimit: int32;

  @doc("Признак обязательности рекламного идентификатора `erId` при активации тарифа.")
  hasErId: boolean;

  @doc("Признак возможности активировать тариф только один раз для одного аккаунта.")
  onlyOne: boolean;

  @doc("Тип расчётного периода: день или месяц.")
  periodType: AdvertisingTariffPeriodType;

  @doc("Количество дней или месяцев в одном периоде. Для дней допускается значение до 365, для месяцев — до 12.")
  @minValue(1)
  @maxValue(365)
  periodValue: int32;

  @doc("Максимальное суммарное количество периодов, доступных для оплаты.")
  @minValue(1)
  payPeriodQuantity: int32;

  @doc("Скидка в процентах за каждый оплачиваемый период после первого.")
  @minValue(0)
  @maxValue(100)
  periodDiscount: decimal128;

  @doc("Условия размещения, включённые в рекламный тариф.")
  placementConditions: AdvertisingTariffPlacementConditionDto[];

  @doc("Признак архивности рекламного тарифа.")
  isArchived: boolean;
}

@doc("Команда создания рекламного тарифа. Идентификатор тарифа формируется системой.")
model CreateAdvertisingTariffCommand is AdvertisingTariffCommandData;

@doc("Команда обновления рекламного тарифа.")
model UpdateAdvertisingTariffCommand {
  @doc("Идентификатор обновляемого рекламного тарифа.")
  id: Primitives.Uuid;

  ...AdvertisingTariffCommandData;
}

@doc("Параметры получения рекламных тарифов.")
model GetAllAdvertisingTariffsCommand {
  @doc("Признак включения архивных тарифов в результат.")
  showArchived: boolean;
}

@doc("Успешный ответ с полным представлением созданного рекламного тарифа.")
model CreateAdvertisingTariffResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingTariffDto>;
}

@doc("Успешный ответ с полным представлением обновлённого рекламного тарифа.")
model UpdateAdvertisingTariffResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingTariffDto>;
}

@doc("Успешный ответ со списком рекламных тарифов.")
model GetAllAdvertisingTariffsResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AdvertisingTariffDto[]>;
}

@doc("UTM-параметры ссылки рекламного баннера.")
model UtmLink {
  @doc("Адрес перехода по рекламному баннеру.")
  url: string;

  @doc("Источник трафика.")
  utmSource: string;

  @doc("Тип трафика.")
  utmMedium: string;

  @doc("Название рекламной кампании.")
  utmCampaign: string;

  @doc("Содержимое рекламной кампании.")
  utmContent: string;

  @doc("Ключевое слово рекламной кампании.")
  utmTerm: string;
}

@doc("База или отдельное помещение, рекламируемые баннером.")
model BannerPromotionTarget {
  @doc("Идентификатор базы.")
  baseId: Primitives.Uuid;

  @doc("Идентификатор помещения. Значение `null` означает всю базу.")
  roomId: Primitives.Uuid | null;
}

@doc("Полное представление рекламного баннера.")
model BannerDto {
  @doc("Идентификатор рекламного баннера.")
  id: Primitives.Uuid;

  @doc("Идентификатор рекламного тарифа.")
  advertisingTariffId: Primitives.Uuid;

  @doc("Идентификатор условия размещения рекламы.")
  advertisingPlacementConditionId: Primitives.Uuid;

  @doc("Ссылка на изображение рекламного баннера.")
  bannerImageUrl: string;

  @doc("Текст рекламного баннера.")
  text: string;

  @doc("Текст кнопки действия.")
  actionButtonText: string;

  @doc("Ссылка и UTM-параметры рекламного баннера.")
  utmLink?: UtmLink;

  @doc("База или помещение, рекламируемые баннером.")
  promotionTarget?: BannerPromotionTarget;

  @doc("Внешний идентификатор рекламного баннера.")
  erId: string;
}

@doc("Команда создания рекламного баннера. Идентификатор баннера формируется системой.")
model CreateBannerCommand is TypeSpec.OmitProperties<BannerDto, "id">;

@doc("Команда обновления рекламного баннера. Требует идентификатор и все поля баннера.")
model UpdateBannerCommand is BannerDto;

@doc("Успешный ответ с полным представлением созданного рекламного баннера.")
model CreateBannerResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<BannerDto>;
}

@doc("Пустой результат успешного обновления рекламного баннера.")
model UpdateBannerResponsePayload {}

@doc("Успешный ответ на обновление рекламного баннера.")
model UpdateBannerResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<UpdateBannerResponsePayload>;
}

@doc("Параметры получения рекламных баннеров.")
model GetAllBannersCommand {
  @doc("Идентификаторы баннеров для фильтрации.")
  bannerIds: Primitives.Uuid[];

  @doc("Признак получения архивных баннеров.")
  isArchive: boolean;
}

@doc("Пользователь, выполнивший изменение рекламного баннера.")
model BannerAuditActor {
  @doc("Идентификатор пользователя.")
  identity: Primitives.Uuid;

  @doc("Признак отсутствия пользователя.")
  isEmpty: boolean;
}

@doc("Сведения о создании и последнем обновлении рекламного баннера.")
model BannerAuditableInfo {
  @doc("Дата и время создания баннера.")
  createdAt: utcDateTime;

  @doc("Пользователь, создавший баннер.")
  createdBy: BannerAuditActor;

  @doc("Дата и время последнего обновления баннера.")
  updatedAt: utcDateTime;

  @doc("Пользователь, последним обновивший баннер.")
  updatedBy: BannerAuditActor;
}

@doc("Сведения об архивации рекламного баннера.")
model BannerArchiveInfo {
  @doc("Признак нахождения баннера в архиве.")
  isArchived: boolean;

  @doc("Дата и время архивации баннера.")
  archivedAt: utcDateTime;
}

@doc("Полное представление рекламного баннера со служебными сведениями.")
model BannerDetailsDto {
  ...BannerDto;

  @doc("Сведения о создании и последнем обновлении баннера.")
  auditableInfo: BannerAuditableInfo;

  @doc("Сведения об архивации баннера.")
  archiveInfo: BannerArchiveInfo;
}

@doc("Данные ответа со списком рекламных баннеров.")
@example(#{
  banners: #[
    #{
      id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      advertisingTariffId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      advertisingPlacementConditionId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      bannerImageUrl: "string",
      text: "string",
      actionButtonText: "string",
      utmLink: #{
        url: "string",
        utmSource: "string",
        utmMedium: "string",
        utmCampaign: "string",
        utmContent: "string",
        utmTerm: "string",
      },
      promotionTarget: #{
        baseId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        roomId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      },
      erId: "string",
      auditableInfo: #{
        createdAt: utcDateTime.fromISO("2026-09-09T14:43:27.555Z"),
        createdBy: #{
          identity: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          isEmpty: true,
        },
        updatedAt: utcDateTime.fromISO("2026-09-09T14:43:27.555Z"),
        updatedBy: #{
          identity: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          isEmpty: true,
        },
      },
      archiveInfo: #{
        isArchived: true,
        archivedAt: utcDateTime.fromISO("2026-09-09T14:43:27.555Z"),
      },
    },
  ],
})
model GetAllBannersResponseBody {
  @doc("Рекламные баннеры.")
  banners: BannerDetailsDto[];
}

@doc("Успешный ответ со списком рекламных баннеров.")
model GetAllBannersResponse {
  @statusCode statusCode: 200;
  @body body: GetAllBannersResponseBody;
}
