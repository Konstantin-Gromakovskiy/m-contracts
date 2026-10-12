using Http;
using OpenAPI;

namespace IdentityService.Employees;

@tag("Employee")
interface Employees {
  @doc("Создание сотрудника")
  @post
  @route("/CreateEmployee")
  @operationId("CreateEmployee")
  CreateEmployee(@body body: CreateEmployeeCommand): CreateEmployeeResponse;

  @doc("Обновление сотрудника. Принимает всю сущность, возвращает обновленную сущность")
  @post
  @route("/UpdateEmployee")
  @operationId("UpdateEmployee")
  UpdateEmployee(@body body: UpdateEmployeeCommand): UpdateEmployeeResponse;

  @doc("Архивирование сотрудника")
  @post
  @route("/ArchiveEmployee")
  @operationId("ArchiveEmployee")
  ArchiveEmployee(@body body: ArchiveEmployeeCommand): ArchiveEmployeeResponse;

  @doc("Восстановление сотрудника из архива. Возвращает восстановленную сущность сотрудника.")
  @post
  @route("/RestoreEmployee")
  @operationId("RestoreEmployee")
  RestoreEmployee(@body body: RestoreEmployeeCommand): RestoreEmployeeResponse;

  @doc("Получение сотрудников базы, включая архивированных")
  @post
  @route("/GetEmployees")
  @operationId("GetEmployees")
  GetEmployees(@body body: GetEmployeesCommand): GetEmployeesResponse;
}
