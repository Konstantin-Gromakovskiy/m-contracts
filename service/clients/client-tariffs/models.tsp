import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../../abac/permissions/models.tsp";

using Http;

namespace ClientsService.ClientTariffs;

@doc("Полное представление группы доступного функционала клиентского тарифа.")
model ClientTariffAvailableFunctionalityGroupDto {
  @doc("Идентификатор группы доступного функционала.")
  id: Primitives.Uuid;

  @doc("Название группы доступного функционала.")
  name: string;

  @doc("Описание группы доступного функционала.")
  description: string;

  @doc("Идентификаторы прав доступа, включённых в группу.")
  permissionIds: AbacService.Permissions.PermissionDto.id[];

  @doc("Признак архивности группы доступного функционала.")
  isArchived: boolean;
}

@doc("Команда создания группы доступного функционала клиентского тарифа. Идентификатор группы формируется системой.")
model CreateClientTariffAvailableFunctionalityGroupCommand is TypeSpec.OmitProperties<ClientTariffAvailableFunctionalityGroupDto, "id">;

@doc("Успешный ответ с полным представлением созданной группы доступного функционала клиентского тарифа.")
model CreateClientTariffAvailableFunctionalityGroupResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<ClientTariffAvailableFunctionalityGroupDto>;
}

@doc("Команда обновления группы доступного функционала клиентского тарифа. Требует идентификатор и все изменяемые поля группы.")
model UpdateClientTariffAvailableFunctionalityGroupCommand is ClientTariffAvailableFunctionalityGroupDto;

@doc("Успешный ответ с полным представлением обновлённой группы доступного функционала клиентского тарифа.")
model UpdateClientTariffAvailableFunctionalityGroupResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<ClientTariffAvailableFunctionalityGroupDto>;
}

@doc("Параметры получения групп доступного функционала клиентских тарифов.")
model ClientTariffAvailableFunctionalityGroupsFilterParams {
  @doc("Признак включения архивных групп в результат: `true` — вернуть все группы, `false` — только неархивные.")
  includeArchived: boolean;
}

@doc("Успешный ответ с массивом групп доступного функционала клиентских тарифов, соответствующих фильтру.")
model GetClientTariffAvailableFunctionalityGroupsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<ClientTariffAvailableFunctionalityGroupDto[]>;
}
