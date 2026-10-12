using Http;
using OpenAPI;

namespace PartnerZonesService.PartnerTariff;

@tag("Partner Tariffs")
@doc("Операции с партнёрскими тарифами.")
interface PartnerTariffs {
  @summary("Создать партнёрский тариф")
  @doc("Создаёт партнёрский тариф доступа и комиссии и возвращает его полное представление.")
  @post
  @route("/CreatePartnerTariffService")
  @operationId("CreatePartnerTariffService")
  CreatePartnerTariffService(
    @body body: CreatePartnerTariffCommand,
  ): CreatePartnerTariffResponse;

  @summary("Обновить партнёрский тариф")
  @doc("Обновляет существующий партнёрский тариф и возвращает его актуальное полное представление.")
  @post
  @route("/UpdatePartnerTariffService")
  @operationId("UpdatePartnerTariffService")
  UpdatePartnerTariffService(
    @body body: UpdatePartnerTariffCommand,
  ): UpdatePartnerTariffResponse;

  @summary("Получить партнёрские тарифы по фильтру")
  @doc("Возвращает партнёрские тарифы с фильтрацией по городам, сферам деятельности и признаку архивности.")
  @post
  @route("/GetPartnerTariffsByFilterService")
  @operationId("GetPartnerTariffsByFilterService")
  GetPartnerTariffsByFilterService(
    @body body: PartnerTariffsByFilterParams,
  ): GetPartnerTariffsByFilterResponse;
}

@tag("Available Functionality Groups")
@doc("Операции с группами доступного функционала партнёрских тарифов.")
interface AvailableFunctionalityGroups {
  @summary("Создать группу доступного функционала")
  @doc("Создаёт группу доступного функционала с указанными правами доступа и возвращает её полное представление.")
  @post
  @route("/CreateAvailableFunctionalityGroupService")
  @operationId("CreateAvailableFunctionalityGroupService")
  CreateAvailableFunctionalityGroupService(
    @body body: CreateAvailableFunctionalityGroupCommand,
  ): CreateAvailableFunctionalityGroupResponse;

  @summary("Обновить группу доступного функционала")
  @doc("Обновляет существующую группу доступного функционала и возвращает её актуальное полное представление.")
  @post
  @route("/UpdateAvailableFunctionalityGroupService")
  @operationId("UpdateAvailableFunctionalityGroupService")
  UpdateAvailableFunctionalityGroupService(
    @body body: UpdateAvailableFunctionalityGroupCommand,
  ): UpdateAvailableFunctionalityGroupResponse;

  @summary("Получить группы доступного функционала")
  @doc("Возвращает группы доступного функционала с возможностью включить архивные группы в результат.")
  @post
  @route("/GetAvailableFunctionalityGroupsByFilterService")
  @operationId("GetAvailableFunctionalityGroupsByFilterService")
  GetAvailableFunctionalityGroupsByFilterService(
    @body body: AvailableFunctionalityGroupsFilterParams,
  ): GetAvailableFunctionalityGroupsByFilterResponse;
}

@tag("Fixed Conditions")
@doc("Операции с фиксированными условиями партнёрских тарифов.")
interface FixedConditions {
  @summary("Создать фиксированное условие")
  @doc("Создаёт фиксированное условие для последующего включения в партнёрские тарифы и возвращает его полное представление.")
  @post
  @route("/CreateFixedConditionService")
  @operationId("CreateFixedConditionService")
  CreateFixedConditionService(
    @body body: CreateFixedConditionCommand,
  ): CreateFixedConditionResponse;

  @summary("Получить фиксированные условия по фильтру")
  @doc("Возвращает доступные пользователю фиксированные условия с фильтрацией по городам, сферам деятельности и признаку архивности. Для каждого условия возвращаются идентификаторы связанных тарифов.")
  @post
  @route("/GetFixedConditionsByFilterService")
  @operationId("GetFixedConditionsByFilterService")
  GetFixedConditionsByFilterService(
    @body body: FixedConditionsByFilterParams,
  ): GetFixedConditionsByFilterResponse;

  @summary("Обновить фиксированное условие")
  @doc("Обновляет существующее фиксированное условие и возвращает его актуальное полное представление.")
  @post
  @route("/UpdateFixedConditionService")
  @operationId("UpdateFixedConditionService")
  UpdateFixedConditionService(
    @body body: UpdateFixedConditionCommand,
  ): UpdateFixedConditionResponse;
}

@tag("Commission Conditions")
@doc("Операции с условиями начисления комиссии партнёрских тарифов.")
interface CommissionConditions {
  @summary("Создать условие начисления комиссии")
  @doc("Создаёт условие начисления комиссии для последующего включения в партнёрские тарифы.")
  @post
  @route("/CreateCommissionConditionService")
  @operationId("CreateCommissionConditionService")
  CreateCommissionConditionService(
    @body body: CreateCommissionConditionCommand,
  ): CreateCommissionConditionResponse;

  @summary("Обновить условие начисления комиссии")
  @doc("Обновляет существующее условие начисления комиссии и возвращает его актуальное полное представление.")
  @externalDocs(
    "https://wiki.yandex.ru/homepage/d750da42741c/texnicheskaja-dokumentacija/api-dokumentacija/api-po-komponentam-funkcionala/4-raschety/4.4-raschet-komissii-za-zakazy/4.4-1.3.01-obnovlenie-uslovija-nachislenija-komiss/",
    "Документация UpdateCommissionConditionService",
  )
  @post
  @route("/UpdateCommissionConditionService")
  @operationId("UpdateCommissionConditionService")
  UpdateCommissionConditionService(
    @body body: UpdateCommissionConditionCommand,
  ): CreateCommissionConditionResponse;

  @summary("Получить условия начисления комиссии по фильтру")
  @doc("Возвращает доступные пользователю условия начисления комиссии с фильтрацией по городам, сферам деятельности и признаку архивности. Для каждого условия возвращаются идентификаторы связанных тарифов.")
  @post
  @route("/GetCommissionConditionsByFilterService")
  @operationId("GetCommissionConditionsByFilterService")
  GetCommissionConditionsByFilterService(
    @body body: CommissionConditionsFilterParams ,
  ): GetCommissionConditionsByFilterResponse;
}
