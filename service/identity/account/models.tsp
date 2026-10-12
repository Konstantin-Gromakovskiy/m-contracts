import "../../common/primitives.tsp";
import "../../common/files.tsp";
import "../../common/responses.tsp";
import "../../abac/roles/models.tsp";
using Http;

namespace IdentityService.Account;

@doc("Модель аккаунта")
model PartnerAccountDto 
{
   @doc("Идентификатор аккаунта")
   id: Primitives.Uuid;
   @doc("Идентификатор клиента")
   clientId: Primitives.Uuid;
   @doc("Имя пользователя")
   firstName: string;
   @doc("Фамилия пользователя")
   lastName: string;
   @doc("Отчество пользователя")
   patronymic?: string;
   @doc("Признак архивности")
   isArchived: boolean;
   @doc("Адрес электронной почты пользователя")
   @format("email")
   email?: string;
   @doc("Код телефона пользователя")
   countryCode: string;
   @doc("Номер телефона пользователя")
   phoneNumber: string;
   @doc("Идентификатор пригласившего пользователя")
   invitedById?: PartnerAccountDto.id;
   @doc("Идентификатор клиентского тарифа пользователя")
   tariffId: Primitives.Uuid;
   @doc("Массив идентификаторов ролей пользователя")
   roleIds:  AbacService.Roles.RoleDto.id[];
   @doc("Массив идентификаторов доступных партнерских ролей пользователя")
   PartnerZonesIds: Primitives.Uuid[];
}

@doc("Данные для обновления авторизованного партнерского аккаунта. Передаются только изменяемые поля.")
model UpdatePersonalInfoCommand {
  @doc("Новый адрес электронной почты.")
  email: PartnerAccountDto.email;
  @doc("Имя владельца аккаунта.")
  firstName: PartnerAccountDto.firstName;
  @doc("Фамилия владельца аккаунта.")
  lastName: PartnerAccountDto.lastName;
}
@doc("Данные авторизованного аккаунта после обновления.")
model GetPartnerAccountResponse extends PartnerAccountDto {}
@doc("Успешный ответ на обновление авторизованного партнерского аккаунта.")
model UpdatePartnerAccountResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<GetPartnerAccountResponse>;
}
