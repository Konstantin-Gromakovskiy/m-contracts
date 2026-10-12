using Http;
using OpenAPI;

namespace IdentityService.Authorization;

@tag("Login")
@doc("Операции авторизации")

interface Login{
@doc("Авторизация в сервисный кабинет")
  @post
  @route("/LoginService")
  @operationId("LoginService")
  LoginService(@body body: LoginCommand): LoginServiceResponse;
}
