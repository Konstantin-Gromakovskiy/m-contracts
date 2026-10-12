import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../permissions/models.tsp";
using Http;

namespace AbacService.Roles;

@doc("Роль сотрудника с набором разрешений.")
model RoleDto {
  @doc("Идентификатор роли.")
  @example("56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c")
  id: Primitives.Uuid;
  @doc("Название роли.")
  @example("Техник")
  name: string;
  @doc("Описание роли.")
  @example("Чинят то, что было сломано")
  description: string;
  @doc("Идентификаторы разрешений роли.")
  permissionIds: AbacService.Permissions.PermissionDto.id[];
}

@doc("Параметры выборки ролей для партнерской зоны.")
model GetRolesCommand {
  @doc("Идентификатор партнерской зоны.")
  partnerZoneId: Primitives.Uuid;
  @doc("Идентификаторы ролей для фильтрации. При пустом массиве возвращаются все роли партнерской зоны.")
  ids: RoleDto.id[];
}

@doc("Успешный ответ со списком ролей.")
model GetRolesResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<RoleDto[]>;
}

@doc("Команда создания роли.")
model CreateRoleCommand is TypeSpec.OmitProperties<RoleDto, "id"> {
  @doc("Идентификатор партнерской зоны.")
  partnerZoneId: Primitives.Uuid;
}

@doc("Успешный ответ на создание роли.")
model CreateRoleResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<RoleDto>;
}

@doc("Команда полного обновления существующей роли.")
model UpdateRoleCommand is RoleDto {
  @doc("Идентификатор партнерской зоны.")
  partnerZoneId: Primitives.Uuid;
}

@doc("Успешный ответ на обновление роли.")
model UpdateRoleResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<RoleDto>;
}

@doc("Команда архивация роли")
model ArchiveRoleCommand is TypeSpec.PickProperties<RoleDto, "id"> {
  @doc("Идентификатор партнерской зоны.")
  partnerZoneId: Primitives.Uuid;
}

@doc("Данные успешного ответа архивации роли.")
model ArchiveRoleResponsePayload {
  @doc("Идентификатор архивированной роли.")
  id: RoleDto.id;
}

@doc("Успешный ответ архивации роли.")
model ArchiveRoleResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<ArchiveRoleResponsePayload>;
}
