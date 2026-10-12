import "./examples.tsp";

using Http;
using OpenAPI;

namespace AbacService.Permissions;

@tag("Permission")
interface Permissions {
  @doc ("Фильтрация осуществляется по индентификаторам permissions, если они переданы и по тарифу партнерской зоны.")
  @post
  @route("/GetPermissions")
  @operationId("GetPermissions")
  @opExample(PermissionsExamples)
  GetPermissions(@body body: GetPermissionsCommand): GetPermissionsResponse;
}
