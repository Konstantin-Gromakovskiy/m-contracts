import "../../common/primitives.tsp";
import "../../common/files.tsp";
import "../../common/responses.tsp";
import "../../identity/account/models.tsp";

using Http;

namespace IdentityService.Authorization;

@doc("Данные для авторизации по email")
model LoginByEmailCommand {
  @doc("Адрес электронной почты пользователя")
  email: IdentityService.Account.PartnerAccountDto.email;

  @doc("Пароль пользователя")
  password: string;
}

@doc("Данные для авторизации по телефону")
model LoginByPhoneCommand {
  @doc("Код телефона пользователя")
  countryCode: IdentityService.Account.PartnerAccountDto.countryCode;

  @doc("Номер телефона пользователя")
  phoneNumber: IdentityService.Account.PartnerAccountDto.phoneNumber;

  @doc("Пароль пользователя")
  password: string;
}

@doc("Данные для авторизации")
union LoginCommand {
  LoginByEmailCommand,
  LoginByPhoneCommand
}


@doc("Токены пользователя и срок действия")
model Tokens {
  @doc("Токен доступа")
  accessToken: string;

  @doc("Токен обновления")
  refreshToken: string;

  @doc("Дата и время окончания срока действия токена доступа")
  expiresAt: utcDateTime;
}

@doc("Успешный ответ на авторизацию")
model LoginServiceResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<Tokens>;
}