using Http;
using OpenAPI;

namespace IdentityService.Account;

@tag("PersonalInfo")
    interface PersonalInfo{
       @doc("Обновляет переданные поля авторизованного партнерского аккаунта и возвращает его актуальные данные.")
        @post
        @route("/UpdatePersonalInfo")
        @operationId("UpdatePersonalInfo")
        UpdatePersonalInfo(
          @body body: UpdatePersonalInfoCommand,
        ): UpdatePartnerAccountResponse;
} 

