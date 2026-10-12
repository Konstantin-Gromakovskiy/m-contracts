import "./models.tsp";

using Http;
using OpenAPI;

namespace PositionsService.Positions;

@tag("Positions")
interface Positions {
  @doc("Получение позиций по фильтрам")
  @post
  @route("/GetPositionsByFilter")
  @operationId("GetPositionsByFilter")
  GetPositionsByFilter(
    @body body: PositionsService.Positions.PositionsFilterParams,
  ): PositionsService.Positions.GetPositionsByFilterResponse;

  @doc("Создание позиции.")
  @post
  @route("/CreatePosition")
  @operationId("CreatePosition")
  CreatePosition(@body body: CreatePositionCommand): CreatePositionResponse;

  @doc("Полное обновление существующей позиции.")
  @post
  @route("/UpdatePosition")
  @operationId("UpdatePosition")
  UpdatePosition(@body body: UpdatePositionCommand): UpdatePositionResponse;

  @doc("Архивирование позиции.")
  @post
  @route("/ArchivePosition")
  @operationId("ArchivePosition")
  ArchivePosition(@body body: ArchivePositionCommand): ArchivePositionResponse;

  @doc("Восстановление позиции из архива.")
  @post
  @route("/RestorePosition")
  @operationId("RestorePosition")
  RestorePosition(@body body: RestorePositionCommand): RestorePositionResponse;
}
