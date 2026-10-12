using Http;
using OpenAPI;

namespace ClientsService.Points;

@tag("Points")
interface Points {
  @doc("Получение истории операций с баллами клиента.")
  @post
  @route("/GetPointsByClientService")
  @operationId("GetPointsByClientService")
  GetPointsByClientService(
    @body body: GetPointsByClientServiceQuery,
  ): GetPointsByClientServiceResponse;

  @summary("Обновить запись о баллах")
  @doc("Обновляет количество баллов, описание причины и признак архивирования записи.")
  @post
  @route("/UpdatePointService")
  @operationId("UpdatePointService")
  UpdatePointService(
    @body body: UpdatePointServiceCommand,
  ): UpdatePointServiceResponse;
}
