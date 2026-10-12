import "../common/primitives.tsp";
import "../common/sources.tsp";
import "../common/files.tsp";
import "../common/responses.tsp";

using Http;

namespace PositionsService.Positions;

@doc("Тип позиции")
enum PositionType {
	@doc("Оборудование")
	Equipment: 0,

	@doc("Услуга")
	Service: 1,
}

model PositionGroup {
	@doc("Идентификатор группы позиций")
	id: Primitives.Uuid;

	@doc("Имя группы позиций")
	@example("Гитары")
	name: string;
}

enum PricingUnit {
	@doc("Тарификация по часам")
	Hour: 1,

	@doc("Тарификация по заказам")
	Order: 2,
}

model PricingRule {
	@doc("Единица тарификации, за которую устанавливается цена")
	@example(PricingUnit.Hour)
	unit: PricingUnit;

	@doc("Количество единиц тарификации, включённых в указанную цену. При тарификации по часам — количество часов. При тарификации по заказам значение в запросе не учитывается, в ответе всегда 1")
	@example(1)
	@minValue(1)
	quantity: int32;
}

@doc("Параметры получения позиций по фильтрам")
model PositionsFilterParams {
	@doc("Id позиции, При пустом массиве возвращаются все позиции")
	ids: PositionDto.id[];

	@doc("Id площадок, к которым пренадлежит позиция, При пустом массиве возвращаются все позиции")
	roomIds: PositionDto.roomIds;

	@doc("Id партнерской зоны")
	partnerZoneId: Primitives.Uuid;

	@doc("Источники: возвращаются позиции, доступные хотя бы в одном из них. При пустом массиве фильтр не применяется")
	sources: Sources.Source[];

	@doc("Строка поиска для фильтрации позиции")
	search?: string;

	@doc("Единица тарификации, за которую устанавливается цена")
	pricingUnit?: PricingUnit;

	@doc("Идентификаторы групп, к которым относятся позиции")
	groupIds: Primitives.Uuid[];

	@doc("Признак включения архивных позиций в результат: `true` — вернуть все позиции, `false` — только неархивные.")
	includeArchived: boolean;
}

@doc("Модель позиции")
model PositionDto {
	@doc("Идентификатор позиции")
	id: Primitives.Uuid;

	@doc("Имя позиции")
	@example("Электро Kramer Striker")
	name: string;

	@doc("Описание позиции")
	@example("Электро Kramer Striker для всех пользователей")
	description?: string;

	@doc("Тип позиции (оборудование/услуга)")
	@example(PositionType.Equipment)
	type: PositionType;

	@doc("Количество на складе")
	@example(10)
	amount: int32;

	@doc("Цена")
	@example(1000)
	price: decimal128;

	@doc("Группа, к которой пренадлежит позиция")
	group: PositionGroup;

	@doc("Площадки, к которым пренадлежит позиция")
	roomIds: Primitives.Uuid[];

	@doc("Источники, в которых доступна позиция")
	@example(#[Sources.Source.Web, Sources.Source.Mobile])
	sources: Sources.Source[];

	@doc("Признак архивности")
	isArchived: boolean;

	@doc("Принцип формирования цены. За время или за заказ")
	pricingRule: PricingRule;

	@doc("Фотографии позиции")
	files: Files.FileDto<Files.FileType.Img>[];
}

@doc("Фотография позиции, используемая при создании или замене фотографии.")
model PositionPhotoPayload {
	@doc("Содержимое фотографии в формате base64.")
	@format("byte")
	fileData: string;

	@doc("Исходное имя файла фотографии.")
	fileName: string;

	@doc("MIME-тип файла фотографии.")
	contentType: string;
}

@doc("Явный признак, что фотографию позиции изменять не требуется.")
model PositionPhotoUnchanged {}

@doc("Данные позиции для команд создания и полного обновления.")
model PositionData {
	@doc("Идентификатор позиции.")
	id: PositionDto.id;

	@doc("Идентификатор партнерской зоны.")
	partnerZoneId: Primitives.Uuid;

	@doc("Имя позиции.")
	@example("Электро Kramer Striker")
	name: string;

	@doc("Описание позиции.")
	@example("Электро Kramer Striker для всех пользователей")
	description?: string;

	@doc("Количество позиции на складе.")
	@example(10)
	amount: int32;

	@doc("Цена позиции.")
	@example(1000)
	price: decimal128;

	@doc("Идентификатор группы позиции.")
	groupId: PositionGroup.id;

	@doc("Идентификаторы площадок, к которым относится позиция.")
	roomIds: PositionDto.roomIds;

	@doc("Источники, в которых доступна позиция.")
	sources: PositionDto.sources;

	@doc("Правило формирования цены.")
	pricingRule: PricingRule;
}

@doc("Команда создания позиции.")
model CreatePositionCommand is TypeSpec.OmitProperties<PositionData, "id"> {
	@doc("Тип позиции: оборудование или услуга. Задаётся при создании и не меняется.")
	@example(PositionType.Equipment)
	type: PositionType;

	@doc("Необязательная фотография позиции.")
	file?: PositionPhotoPayload;
}

@doc("Команда полного обновления позиции.")
model UpdatePositionCommand extends PositionData {
	file: PositionPhotoPayload | PositionPhotoUnchanged | null;
}

@doc("Команда архивирования позиции.")
model ArchivePositionCommand {
	@doc("Идентификатор позиции.")
	id: PositionDto.id;

	@doc("Идентификатор партнерской зоны.")
	partnerZoneId: Primitives.Uuid;
}

@doc("Команда восстановления позиции из архива.")
model RestorePositionCommand {
	@doc("Идентификатор позиции.")
	id: PositionDto.id;

	@doc("Идентификатор партнерской зоны.")
	partnerZoneId: Primitives.Uuid;
}

@doc("Успешный ответ с получением списка позиций по фильтрам.")
model GetPositionsByFilterResponse {
	@statusCode statusCode: 200;
	@body body: Responses.ApiResponse<PositionDto[]>;
}

@doc("Успешный ответ на создание позиции.")
model CreatePositionResponse {
	@statusCode statusCode: 200;
	@body body: Responses.ApiResponse<PositionDto>;
}

@doc("Успешный ответ на обновление позиции.")
model UpdatePositionResponse {
	@statusCode statusCode: 200;
	@body body: Responses.ApiResponse<PositionDto>;
}

@doc("Данные успешного ответа архивирования позиции.")
model ArchivePositionResponsePayload {
	@doc("Идентификатор архивированной позиции.")
	id: PositionDto.id;
}

@doc("Успешный ответ архивирования позиции.")
model ArchivePositionResponse {
	@statusCode statusCode: 200;
	@body body: Responses.ApiResponse<ArchivePositionResponsePayload>;
}

@doc("Успешный ответ восстановления позиции из архива.")
model RestorePositionResponse {
	@statusCode statusCode: 200;
	@body body: Responses.ApiResponse<PositionDto>;
}
