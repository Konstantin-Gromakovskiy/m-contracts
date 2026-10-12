using Http;
using OpenAPI;

@service(#{ title: "Identity Service" })
@tagMetadata("Login", #{
  description: "Операции авторизации по интерфейсам",
})
@tagMetadata("Permissions", #{
  description: "Операции получения прав доступа.",
})

@route("/rpc/IdentityService")
namespace IdentityService;
