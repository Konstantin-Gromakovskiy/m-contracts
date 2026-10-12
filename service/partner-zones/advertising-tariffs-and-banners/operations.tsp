using Http;
using OpenAPI;

namespace PartnerZonesService.AdvertisingTariffsAndBanners;

@tag("Advertising Tariffs")
@doc("Операции с рекламными тарифами.")
interface AdvertisingTariffs {
  @summary("Создать рекламный тариф")
  @doc("Создаёт рекламный тариф и возвращает его полное представление.")
  @post
  @route("/CreateAdvertisingTariffService")
  @operationId("CreateAdvertisingTariffService")
  CreateAdvertisingTariffService(
    @body body: CreateAdvertisingTariffCommand,
  ): CreateAdvertisingTariffResponse;

  @summary("Обновить рекламный тариф")
  @doc("Обновляет рекламный тариф и возвращает его актуальное полное представление.")
  @post
  @route("/UpdateAdvertisingTariffService")
  @operationId("UpdateAdvertisingTariffService")
  UpdateAdvertisingTariffService(
    @body body: UpdateAdvertisingTariffCommand,
  ): UpdateAdvertisingTariffResponse;

  @summary("Получить рекламные тарифы")
  @doc("Возвращает рекламные тарифы с возможностью включить архивные тарифы в результат.")
  @post
  @route("/GetAllAdvertisingTariffsService")
  @operationId("GetAllAdvertisingTariffsService")
  GetAllAdvertisingTariffsService(
    @body body: GetAllAdvertisingTariffsCommand,
  ): GetAllAdvertisingTariffsResponse;
}

@tag("Advertising Placement Conditions")
@doc("Операции с условиями размещения рекламы.")
interface AdvertisingPlacementConditions {
  @summary("Создать условие размещения рекламы")
  @doc("Создаёт условие размещения рекламы и возвращает его полное представление.")
  @post
  @route("/CreateAdvertisingPlacementConditionService")
  @operationId("CreateAdvertisingPlacementConditionService")
  CreateAdvertisingPlacementConditionService(
    @body body: CreateAdvertisingPlacementConditionCommand,
  ): CreateAdvertisingPlacementConditionResponse;

  @summary("Обновить условие размещения рекламы")
  @doc("Обновляет стоимость, архивность, диапазон мест приоритета и место размещения рекламы.")
  @post
  @route("/UpdateAdvertisingPlacementConditionService")
  @operationId("UpdateAdvertisingPlacementConditionService")
  UpdateAdvertisingPlacementConditionService(
    @body body: UpdateAdvertisingPlacementConditionCommand,
  ): UpdateAdvertisingPlacementConditionResponse;

  @summary("Получить условия размещения рекламы")
  @doc("Возвращает условия размещения рекламы с возможностью включить архивные сущности в результат.")
  @post
  @route("/GetAdvertisingPlacementConditionsByFilterService")
  @operationId("GetAdvertisingPlacementConditionsByFilterService")
  GetAdvertisingPlacementConditionsByFilterService(
    @body body: AdvertisingPlacementConditionsFilterParams,
  ): GetAdvertisingPlacementConditionsByFilterResponse;
}

@tag("Advertising Banners")
@doc("Операции с рекламными баннерами.")
interface AdvertisingBanners {
  @summary("Создать рекламный баннер")
  @doc("Создаёт рекламный баннер и возвращает его полное представление.")
  @post
  @route("/CreateBannerService")
  @operationId("CreateBannerService")
  CreateBannerService(
    @body body: CreateBannerCommand,
  ): CreateBannerResponse;

  @summary("Обновить рекламный баннер")
  @doc("Обновляет существующий рекламный баннер.")
  @post
  @route("/UpdateBannerService")
  @operationId("UpdateBannerService")
  UpdateBannerService(
    @body body: UpdateBannerCommand,
  ): UpdateBannerResponse;

  @summary("Получить рекламные баннеры")
  @doc("Возвращает рекламные баннеры с фильтрацией по идентификаторам и признаку архивации.")
  @post
  @route("/GetAllBannersService")
  @operationId("GetAllBannersService")
  GetAllBannersService(
    @body body: GetAllBannersCommand,
  ): GetAllBannersResponse;
}
