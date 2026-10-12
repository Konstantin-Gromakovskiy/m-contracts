import "../../common/responses.tsp";
import "../../abac/permissions/models.tsp";

using Http;

namespace IdentityService.Permissions;

@doc("Домен прав доступа.")
enum PermissionDomain {
  @doc("Права доступа партнёрского кабинета.")
  Partner: 0;

  @doc("Права доступа сервисного кабинета.")
  Service: 1;

  @doc("Права доступа мобильного приложения.")
  Mobile: 2;
}

@doc("Фильтр прав доступа по доменам.")
@example(#{
  domains: #[PermissionDomain.Partner, PermissionDomain.Service],
})
model GetAllPermissionsServiceQuery {
  @doc("Домены прав доступа для выборки. Можно передать несколько значений.")
  domains: PermissionDomain[];
}

@doc("Успешный ответ с массивом прав доступа выбранных доменов.")
model GetAllPermissionsServiceResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AbacService.Permissions.PermissionDto[]>;
}
