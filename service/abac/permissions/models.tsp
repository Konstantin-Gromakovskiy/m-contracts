import "../../common/primitives.tsp";
import "../../common/responses.tsp";

using Http;

namespace AbacService.Permissions;

enum PermissionType {
  Create: "create";
  Update: "update";
  View: "view";
  Delete: "delete";
}

  model PermissionDescriptor {
    @doc("Ключ домена, для которого существует разрешение. Используются строчные латинские буквы, `_` и `-`; разделители не могут быть первым или последним символом.")
    @example("partner")
    @pattern("^[a-z]+(?:[a-z_-]*[a-z]+)?$")
    domain: string;

    @doc("Ключ категории разрешений. Используются строчные латинские буквы, `_` и `-`; разделители не могут быть первым или последним символом.")
    @example("profile")
    @pattern("^[a-z]+(?:[a-z_-]*[a-z]+)?$")
    category: string;

    @doc("Ключ группы разрешений. Используются строчные латинские буквы, `_` и `-`; разделители не могут быть первым или последним символом.")
    @example("notifications")
    @pattern("^[a-z]+(?:[a-z_-]*[a-z]+)?$")
    group: string;

    @doc("Действие, которое позволяет делать разрешение")
    @example(PermissionType.View)
    type: PermissionType
  }

@doc("Разрешение, доступное в составе роли.")
model PermissionDto {
  @doc("Идентификатор разрешения.")
  @example("56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c")
  id: Primitives.Uuid;
  code: PermissionDescriptor;

};

@doc("Параметры выборки permissions.")
model GetPermissionsCommand {
  @doc("Идентификаторы permissions для фильтрации. При пустом массиве возвращаются все permissions тарифа партнерской зоны.")
  ids: PermissionDto.id[];
  @doc("Идентификатор партнёрской зоны.")
  partnerZoneId: Primitives.Uuid;
}

@doc("Успешный ответ со списком permissions.")
model GetPermissionsResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PermissionDto[]>;
}
