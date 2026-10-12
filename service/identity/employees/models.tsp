import "../../common/primitives.tsp";
import "../../common/files.tsp";
import "../../common/responses.tsp";
using Http;

namespace IdentityService.Employees;

@doc("Полное представление сотрудника.")
model EmployeeDto {
  @doc("Идентификатор партнерской зоны, к которой относится сотрудник.")
  @example("c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1")
  partnerZoneId: Primitives.Uuid;
  @doc("Имя сотрудника.")
  @example("Иван")
  firstName: string;
  @doc("Фамилия сотрудника.")
  @example("Иванов")
  lastName: string;
  @doc("Отчество сотрудника, если указано.")
  @example("Иванович")
  patronymic?: string;
  @doc("Номер телефона сотрудника.")
  @example("9992394123")
  phoneNumber: string;
  @doc("Код страны для номера телефона.В формате +7")
  @example("+7")
  countryCode: string;
  @doc("Локаль сотрудника, в формате ru_RU")
  @example("ru_RU")
  locale: string;
  @doc("Адрес электронной почты сотрудника.")
  @example("ivan.ivanov@example.com")
  @format("email")
  email: string;
  @doc("Идентификаторы баз, к которым сотрудник имеет доступ.")
  @example(#["60a927a8-5b73-48b8-a2c8-1cd33ecfb333"])
  baseIds: Primitives.Uuid[];
  @doc("Роль сотрудника. Например Администратор/Владелец. Используется одна, но добавлена коллекция, если потребуется расширение")
  @example(#["56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c"])
  roleIds: Primitives.Uuid[];
  @doc("Идентификатор сотрудника.")
  id: Primitives.Uuid;
  @doc("Признак, что сотрудник архивирован.")
  isArchived: boolean;
  @doc("Признак, что сотрудник активен - авторизовывался после приглашения.")
  isActive: boolean;
  @doc("Фотографии сотрудника, сохраненные в файловом хранилище.")
  files: Files.FileDto<Files.FileType.Img>[];
}

@doc("Доступная сотруднику база.")
model EmployeeAllowedBaseDto {
  @doc("Идентификатор базы.")
  baseId: Primitives.Uuid;
  @doc("Признак, что база архивирована.")
  isArchived: boolean;
}

@doc("Файл фотографии сотрудника, используемый при создании или замене фотографии.")
model EmployeePhotoPayload {
  @doc("Содержимое фотографии в формате base64.")
  @format("byte")
  fileData: string;
  @doc("Исходное имя файла фотографии.")
  fileName: string;
  @doc("MIME-тип файла фотографии.")
  contentType: string;
}

@doc("Явный признак, что фотографию сотрудника изменять не требуется.")
model EmployeePhotoUnchanged {}

@doc("Команда создания сотрудника.")
model CreateEmployeeCommand is TypeSpec.OmitProperties<EmployeeDto, "id" | "isArchived" | "isActive" | "files"> {
  @doc("Необязательная фотография сотрудника.")
  file?: EmployeePhotoPayload;
}

@doc("Команда обновления сотрудника. Требует передачу полной сущности.")
model UpdateEmployeeCommand is TypeSpec.OmitProperties<EmployeeDto, "isArchived" | "isActive" | "files"> {
  @doc("Фотография сотрудника: пустой объект сохраняет текущую, объект заменяет ее, null удаляет.")
  file: EmployeePhotoPayload | EmployeePhotoUnchanged | null;
}

@doc("Команда архивирования сотрудника.")
model ArchiveEmployeeCommand is TypeSpec.PickProperties<EmployeeDto, "id"> {
  @doc("Идентификатор партнерской зоны сотрудника.")
  @example("c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1")
  partnerZoneId: Primitives.Uuid;
}

@doc("Команда восстановления сотрудника из архива.")
model RestoreEmployeeCommand is TypeSpec.PickProperties<EmployeeDto, "id"> {
  @doc("Идентификатор партнерской зоны сотрудника.")
  @example("c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1")
  partnerZoneId: Primitives.Uuid;
}

@doc("Параметры выборки сотрудников, работающих на указанной базе.")
model GetEmployeesCommand {
  @doc("Идентификатор партнерской зоны.")
    @example("c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1")
  partnerZoneId: Primitives.Uuid;
  @doc("Идентификаторы базы. При пустом массиве происходит выборка по всем базам")
  @example(#["c509f9a8-26f4-4254-b2c8-04d6f1bcbfe1"])
  baseIds: Primitives.Uuid[];
}

@doc("Успешный ответ на создание сотрудника.")
model CreateEmployeeResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<EmployeeDto>;
}

@doc("Успешный ответ на обновление сотрудника.")
model UpdateEmployeeResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<EmployeeDto>;
}

@doc("Данные успешного ответа архивирования сотрудника.")
model ArchiveEmployeeResponsePayload {
  @doc("Идентификатор архивированного сотрудника.")
  id: Primitives.Uuid;
}

@doc("Успешный ответ на архивирование сотрудника с идентификатором сотрудника.")
model ArchiveEmployeeResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<ArchiveEmployeeResponsePayload>;
}

@doc("Успешный ответ на восстановление сотрудника из архива.")
model RestoreEmployeeResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<EmployeeDto>;
}

@doc("Успешный ответ со списком сотрудников, включая архивированных.")
model GetEmployeesResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<EmployeeDto[]>;
}
