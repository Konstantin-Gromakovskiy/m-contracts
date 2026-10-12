using Http;
using OpenAPI;

namespace IdentityService.Permissions;

@tag("Permission")
@doc("Операции получения прав доступа.")
interface Permissions {
  @summary("Получить права доступа")
  @doc("Возвращает права доступа, относящиеся к переданным доменам.")
  @post
  @route("/GetAllPermissionsService")
  @operationId("GetAllPermissionsService")
  GetAllPermissionsService(
    @body body: GetAllPermissionsServiceQuery,
  ): GetAllPermissionsServiceResponse;
}
