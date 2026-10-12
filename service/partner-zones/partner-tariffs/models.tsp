import "../../common/primitives.tsp";
import "../../common/responses.tsp";
import "../../abac/permissions/models.tsp";

using Http;

namespace PartnerZonesService.PartnerTariff;

@doc("Тип расчётного периода партнёрского тарифа.")
enum PartnerTariffPeriodType {
  @doc("Расчётный период задаётся в днях.")
  Day: 0,

  @doc("Расчётный период задаётся в месяцах.")
  Month: 1,
}

@doc("Расчётный период партнёрского тарифа.")
model PartnerTariffPeriodDto {
  @doc("Тип расчётного периода.")
  type: PartnerTariffPeriodType;

  @doc("Количество дней или месяцев в одном периоде")
  @minValue(1)
  @maxValue(365)
  quantity: int32;
}

@doc("Тип сущности, за которую начисляется фиксированная стоимость.")
enum FixedConditionEntityType {
  @doc("Объект партнёра.")
  Object: 0,

  @doc("Площадка партнёра.")
  Room: 1,
}


@doc("Полное представление фиксированного условия партнёрского тарифа.")
model FixedConditionDto {
  @doc("Идентификатор фиксированного условия.")
  id: Primitives.Uuid;

  @doc("Название условия.")
  name: string;

  @doc("Стоимость за период. Допускается значение 0.")
  @minValue(0)
  pricePerPeriod: decimal128;

  @doc("Идентификаторы городов, к которым привязано условие.")
  cityIds: Primitives.Uuid[] ;

  @doc("Идентификаторы сфер деятельности, к которым привязано условие.")
  sphereIds: Primitives.Uuid[];

  @doc("Тип сущности, за которую начисляется фиксированная стоимость.")
  fixedConditionEntityType: FixedConditionEntityType;

  @doc("Идентификаторы партнёрских тарифов, связанных с фиксированным условием.")
  tariffIds: PartnerTariffDto.id[];

  @doc("Признак архивности условия: `true` — активные архивированные, `false` — только активные.")
  isArchived: boolean;
}

@doc("Значение комиссии, заданное фиксированной суммой или процентом.")
model AmountOrPercent {
  @doc("Формат значения комиссии: `true` — процент, `false` — фиксированная сумма.")
  asPercent: boolean;

  @doc("Размер комиссии. Значение должно быть неотрицательным.")
  @minValue(0)
  value: float64;
}

@doc("Полное представление условия начисления комиссии партнёрского тарифа.")
model CommissionConditionDto {
  @doc("Идентификатор условия комиссии.")
  id: Primitives.Uuid;

  @doc("Название условия начисления комиссии.")
  name: string;
  
  @doc("Значение комиссии для резервов.")
  reserve: AmountOrPercent;

  @doc("Значение комиссии для закрытых заказов.")
  closed: AmountOrPercent;

  @doc("Значение комиссии для поступивших заявок.")
  requestNew: AmountOrPercent;

  @doc("Значение комиссии для подтверждённых заявок.")
  requestConfirmed: AmountOrPercent;

  @doc("Признак учёта дополнительных позиций при расчёте комиссии: `true` — учитывать позиции, `false` — рассчитывать только от стоимости площадки.")
  considerPositions: boolean;

  @doc("Идентификаторы городов, для которых действует условие. Если поле не передано или равно `null`, ограничение по городам отсутствует.")
  cityIds?: Primitives.Uuid[] | null;

  @doc("Идентификаторы сфер деятельности, для которых действует условие. Если поле не передано или равно `null`, ограничение по сферам отсутствует.")
  sphereIds?: Primitives.Uuid[] | null;

  @doc("Идентификаторы источников заказов, для которых действует условие. Если поле не передано или равно `null`, условие применяется ко всем источникам.")
  sourceIds?: Primitives.Uuid[] | null;

  @doc("Идентификаторы партнёрских тарифов, связанных с условием начисления комиссии.")
  tariffIds: PartnerTariffDto.id[];

  @doc("Признак архивности условия: `true` — активные архивированные, `false` — только активные.")
  isArchived: boolean;
}

@doc("Полное представление группы доступного функционала партнёрского тарифа.")
model AvailableFunctionalityGroupDto {
  @doc("Идентификатор группы доступного функционала.")
  id: Primitives.Uuid;

  @doc("Название группы доступного функционала.")
  name: string;

  @doc("Описание группы доступного функционала.")
  description: string;

  @doc("Идентификаторы прав доступа, включённых в группу.")
  permissionIds: AbacService.Permissions.PermissionDto.id[];

  @doc("Признак архивности группы доступного функционала.")
  isArchived: boolean;
}

@doc("Полное представление партнёрского тарифа доступа и комиссии.")
model PartnerTariffDto {
  @doc("Идентификатор партнёрского тарифа.")
  id: Primitives.Uuid;

  @doc("Название тарифа.")
  name: string;

  @doc("Подробное описание тарифа.")
  description: string;

  @doc("Расчётный период тарифа.")
  period: PartnerTariffPeriodDto;

  @doc("Ограничение на суммарное количество периодов, которые можно приобрести по тарифу.")
  @minValue(1)
  payPeriodLimit: int32;

  @doc("Скидка в процентах за каждый оплачиваемый период после первого.")
  @minValue(0)
  @maxValue(100)
  discount: decimal128;

  @doc("Идентификаторы фиксированных условий по периодам. Пустой массив означает отсутствие условий.")
  fixedConditionIds: FixedConditionDto.id[];

  @doc("Идентификаторы условий комиссии по заказам. Пустой массив означает отсутствие условий.")
  commissionConditionIds: CommissionConditionDto.id[];

  @doc("Идентификаторы партнёрских зон, в которых тариф доступен для активации. Пустой массив означает доступность во всех зонах.")
  allowedPartnerZoneIds: Primitives.Uuid[];

  @doc("Идентификаторы групп доступного функционала, предоставляемых после активации тарифа. Пустой массив означает отсутствие назначенных групп.")
  availableFunctionalityGroupIds: AvailableFunctionalityGroupDto.id[];

  @doc("Дата и время начала доступности тарифа для активации.")
  from: utcDateTime;

  @doc("Дата и время окончания доступности тарифа для активации.")
  to: utcDateTime;

  @doc("Общий лимит активаций тарифа по всем партнёрским зонам. Если не задан, количество  не ограничено.")
  @minValue(1)
  activationCount?: int32;

  @doc("Признак возможности активировать тариф только один раз в рамках одной партнёрской зоны.")
  onlyOnce: boolean;

  @doc("Признак архивности партнёрского тарифа.")
  isArchived: boolean;
}

@doc("Команда создания партнёрского тарифа. Идентификатор тарифа формируется системой.")
model CreatePartnerTariffCommand is TypeSpec.OmitProperties<PartnerTariffDto, "id">;

@doc("Успешный ответ с полным представлением созданного партнёрского тарифа.")
model CreatePartnerTariffResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PartnerTariffDto>;
}

@doc("Команда обновления партнёрского тарифа. Требует идентификатор и все поля тарифа.")
model UpdatePartnerTariffCommand is PartnerTariffDto;

@doc("Успешный ответ с полным представлением обновлённого партнёрского тарифа.")
model UpdatePartnerTariffResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PartnerTariffDto>;
}

@doc("Параметры получения партнёрских тарифов по фильтру.")
model PartnerTariffsByFilterParams {
  @doc("Идентификаторы городов, для которых доступны тарифы. Пустой массив означает отсутствие ограничения по городам.")
  cityIds: Primitives.Uuid[];

  @doc("Идентификаторы сфер деятельности, для которых доступны тарифы. Пустой массив означает отсутствие ограничения по сферам.")
  sphereIds: Primitives.Uuid[];

  @doc("Признак включения архивных тарифов в результат: `true` — включать архивные, `false` — возвращать только неархивные.")
  isArchived: boolean;
}

@doc("Успешный ответ с массивом партнёрских тарифов, соответствующих фильтру.")
model GetPartnerTariffsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<PartnerTariffDto[]>;
}

@doc("Команда создания группы доступного функционала. Идентификатор группы формируется системой.")
model CreateAvailableFunctionalityGroupCommand is TypeSpec.OmitProperties<AvailableFunctionalityGroupDto, "id">;

@doc("Успешный ответ с полным представлением созданной группы доступного функционала.")
model CreateAvailableFunctionalityGroupResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AvailableFunctionalityGroupDto>;
}

@doc("Команда обновления группы доступного функционала. Требует идентификатор и все изменяемые поля группы.")
model UpdateAvailableFunctionalityGroupCommand is AvailableFunctionalityGroupDto;

@doc("Успешный ответ с полным представлением обновлённой группы доступного функционала.")
model UpdateAvailableFunctionalityGroupResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AvailableFunctionalityGroupDto>;
}

@doc("Параметры получения групп доступного функционала.")
model AvailableFunctionalityGroupsFilterParams {
  @doc("Признак включения архивных групп в результат: `true` — вернуть все группы, `false` — только неархивные.")
  includeArchived: boolean;
}

@doc("Успешный ответ с массивом групп доступного функционала, соответствующих фильтру.")
model GetAvailableFunctionalityGroupsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<AvailableFunctionalityGroupDto[]>;
}

@doc("Команда создания фиксированного условия. Идентификатор условия формируется системой, связи с тарифами возвращаются только в ответе.")
model CreateFixedConditionCommand is TypeSpec.OmitProperties<FixedConditionDto, "id" | "tariffIds">;

@doc("Команда обновления существующего фиксированного условия. Требует идентификатор и все изменяемые поля условия.")
model UpdateFixedConditionCommand is TypeSpec.OmitProperties<FixedConditionDto, "tariffIds">;

@doc("Успешный ответ с полным представлением созданного фиксированного условия.")
model CreateFixedConditionResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<FixedConditionDto>;
}

@doc("Успешный ответ с полным представлением обновлённого фиксированного условия.")
model UpdateFixedConditionResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<FixedConditionDto>;
}

@doc("Команда создания условия начисления комиссии. Идентификатор условия формируется системой, связи с тарифами возвращаются только в ответе.")
model CreateCommissionConditionCommand is TypeSpec.OmitProperties<CommissionConditionDto, "id" | "tariffIds">;

@doc("Команда обновления существующего условия начисления комиссии.")
model UpdateCommissionConditionCommand {
  @doc("Идентификатор аккаунта, от имени которого обновляется условие комиссии.")
  accountId: Primitives.Uuid;

  @doc("Идентификатор обновляемого условия комиссии.")
  id: Primitives.Uuid;

  @doc("Название условия начисления комиссии.")
  name: string;

  @doc("Значение комиссии для резервов.")
  reserve: AmountOrPercent;

  @doc("Значение комиссии для закрытых заказов.")
  closed: AmountOrPercent;

  @doc("Значение комиссии для поступивших заявок.")
  requestNew: AmountOrPercent;

  @doc("Значение комиссии для подтверждённых заявок.")
  requestConfirmed: AmountOrPercent;

  @doc("Признак учёта дополнительных позиций при расчёте комиссии: `true` — учитывать позиции, `false` — рассчитывать только от стоимости площадки.")
  considerPositions: boolean;

  @doc("Идентификаторы городов, для которых действует условие. Если поле не передано или равно `null`, ограничение по городам отсутствует.")
  cityIds?: Primitives.Uuid[] | null;

  @doc("Идентификаторы сфер деятельности, для которых действует условие. Если поле не передано или равно `null`, ограничение по сферам отсутствует.")
  sphereIds?: Primitives.Uuid[] | null;

  @doc("Идентификаторы источников заказов, для которых действует условие. Если поле не передано или равно `null`, условие применяется ко всем источникам.")
  sourceIds?: Primitives.Uuid[] | null;

  @doc("Признак архивности условия.")
  isArchived: boolean;
}

@doc("Успешный ответ с полным представлением созданного условия начисления комиссии.")
model CreateCommissionConditionResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<CommissionConditionDto>;
}

@doc("Параметры получения фиксированных условий по фильтру.")
model FixedConditionsByFilterParams {
  @doc("Идентификаторы городов, для которых действуют условия. Пустой массив означает отсутствие ограничения по городам.")
  cityIds: Primitives.Uuid[] ;

  @doc("Идентификаторы сфер деятельности, для которых действуют условия. Пустой массив означает отсутствие ограничения по сферам.")
  sphereIds: Primitives.Uuid[];

  @doc("Признак архивности возвращаемых условий: `true` — активные архивированные, `false` — только активные.")
  isArchived: boolean;
}

@doc("Успешный ответ с массивом фиксированных условий, соответствующих фильтру.")
model GetFixedConditionsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<FixedConditionDto[]>;
}

@doc("Параметры получения условий начисления комиссии по фильтру.")
model CommissionConditionsFilterParams  {
  @doc("Идентификаторы городов, для которых действуют условия. Пустой массив означает отсутствие ограничения по городам.")
  cityIds: Primitives.Uuid[];

  @doc("Идентификаторы сфер деятельности, для которых действуют условия. Пустой массив означает отсутствие ограничения по сферам.")
  sphereIds: Primitives.Uuid[];

  @doc("Признак архивности возвращаемых условий: `true` — активные архивированные, `false` — только активные.")
  isArchived: boolean;
}

@doc("Успешный ответ с массивом условий начисления комиссии, соответствующих фильтру.")
model GetCommissionConditionsByFilterResponse {
  @statusCode statusCode: 200;
  @body body: Responses.ApiResponse<CommissionConditionDto[]>;
}
