using Http;
using OpenAPI;

namespace AbacService.Roles;

@tag("Role")
interface Roles {
  @doc("Получение ролей.")
  @post
  @route("/GetRoles")
  @operationId("GetRoles")
  GetRoles(@body body: GetRolesCommand): GetRolesResponse;

  @doc("Создание роли.")
  @post
  @route("/CreateRole")
  @operationId("CreateRole")
  CreateRole(@body body: CreateRoleCommand): CreateRoleResponse;

  @doc("Полное обновление существующей роли.")
  @post
  @route("/UpdateRole")
  @operationId("UpdateRole")
  UpdateRole(@body body: UpdateRoleCommand): UpdateRoleResponse;

  @doc("Архивирование роли")
  @post
  @route("/ArchiveRole")
  @operationId("ArchiveRole")
  ArchiveRole(@body body: ArchiveRoleCommand): ArchiveRoleResponse;
}
