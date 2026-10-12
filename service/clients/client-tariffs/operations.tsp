using Http;
using OpenAPI;

namespace ClientsService.ClientTariffs;

@tag("Client Tariff Available Functionality Groups")
@doc("Операции с группами доступного функционала клиентских тарифов.")
interface ClientTariffAvailableFunctionalityGroups {
  @summary("Создать группу доступного функционала клиентского тарифа")
  @doc("Создаёт группу доступного функционала клиентского тарифа с указанными правами доступа и возвращает её полное представление.")
  @post
  @route("/CreateClientTariffAvailableFunctionalityGroupService")
  @operationId("CreateClientTariffAvailableFunctionalityGroupService")
  CreateClientTariffAvailableFunctionalityGroupService(
    @body body: CreateClientTariffAvailableFunctionalityGroupCommand,
  ): CreateClientTariffAvailableFunctionalityGroupResponse;

  @summary("Обновить группу доступного функционала клиентского тарифа")
  @doc("Обновляет существующую группу доступного функционала клиентского тарифа и возвращает её актуальное полное представление.")
  @post
  @route("/UpdateClientTariffAvailableFunctionalityGroupService")
  @operationId("UpdateClientTariffAvailableFunctionalityGroupService")
  UpdateClientTariffAvailableFunctionalityGroupService(
    @body body: UpdateClientTariffAvailableFunctionalityGroupCommand,
  ): UpdateClientTariffAvailableFunctionalityGroupResponse;

  @summary("Получить группы доступного функционала клиентских тарифов")
  @doc("Возвращает группы доступного функционала клиентских тарифов с возможностью включить архивные группы в результат.")
  @post
  @route("/GetClientTariffAvailableFunctionalityGroupsByFilterService")
  @operationId("GetClientTariffAvailableFunctionalityGroupsByFilterService")
  GetClientTariffAvailableFunctionalityGroupsByFilterService(
    @body body: ClientTariffAvailableFunctionalityGroupsFilterParams,
  ): GetClientTariffAvailableFunctionalityGroupsByFilterResponse;
}
