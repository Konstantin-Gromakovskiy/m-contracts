import "../../common/primitives.tsp";
import "../../common/sources.tsp";

namespace DiscountsService.Shared;

@doc("Тип значения скидки")
enum DiscountValueType {
  @doc("Скидка в процентах")
  Percent: "percent",

  @doc("Скидка в рублях")
  Fixed: "fixed",
}

@doc("Значение скидки. Задаётся либо в процентах, либо в рублях.")
model DiscountValue {
  @doc("Тип значения скидки")
  @example(DiscountValueType.Percent)
  type: DiscountValueType;

  @doc("Размер скидки. Для `percent` — минимум 5, для `fixed` — минимум 100 рублей.")
  @example(10)
  @minValue(5)
  value: int32;
}

@doc("Ограничения на количество применений скидки. `null` — без ограничений.")
model DiscountLimits {
  @doc("Максимальное число завершённых заказов, на которые действует скидка")
  @example(100)
  @minValue(1)
  maxOrders: int32 | null;

  @doc("Максимальное число завершённых заказов с этой скидкой для одного клиента")
  @example(1)
  @minValue(1)
  maxOrdersPerClient: int32 | null;
}

@doc("Статистика использования скидки")
model DiscountUsage {
  @doc("Количество завершённых заказов, в которых применена скидка")
  @example(12)
  @minValue(0)
  completedOrders: int32;
}

@doc("День недели")
enum DayOfWeek {
  Monday: "monday",
  Tuesday: "tuesday",
  Wednesday: "wednesday",
  Thursday: "thursday",
  Friday: "friday",
  Saturday: "saturday",
  Sunday: "sunday",
}

@doc("Диапазон времени суток")
model TimeRange {
  @doc("Начало диапазона")
  @example(plainTime.fromISO("10:00:00"))
  from: plainTime;

  @doc("Конец диапазона")
  @example(plainTime.fromISO("18:00:00"))
  to: plainTime;
}

@doc("Календарный период")
model DatePeriod {
  @doc("Первая дата периода")
  @example(plainDate.fromISO("2026-10-01"))
  from: plainDate;

  @doc("Последняя дата периода")
  @example(plainDate.fromISO("2026-10-31"))
  to: plainDate;
}

@doc("Диапазон опции по количеству человек. Одно число задаётся равными `from` и `to`.")
model HumanRange {
  @doc("Минимальное количество человек")
  @example(2)
  @minValue(1)
  from: int32;

  @doc("Максимальное количество человек")
  @example(4)
  @minValue(1)
  to: int32;
}

@doc("Опция, на которую распространяется скидка")
model OptionRule {
  @doc("Идентификатор опции")
  id: Primitives.Uuid;

  @doc("Диапазон опции по количеству человек. `null` — любой диапазон.")
  humanRange: HumanRange | null;
}

@doc("""
  Условия активации скидки. Для всех списков пустой массив означает «все»,
  для `null` — «без ограничения».
  """)
model DiscountConditions {
  @doc("Объекты, на которых действует скидка. Пустой массив — все объекты.")
  objectIds: Primitives.Uuid[];

  @doc("Площадки и услуги, на которых действует скидка. Пустой массив — все площадки и услуги объекта.")
  resourceIds: Primitives.Uuid[];

  @doc("Минимальная длительность заказа в часах")
  @example(1)
  @minValue(1)
  minDurationHours: int32;

  @doc("Опции, на которые распространяется скидка. Пустой массив — все опции.")
  options: OptionRule[];

  @doc("Источники (интерфейсы), в которых доступна скидка. Пустой массив — все источники.")
  @example(#[Sources.Source.Web, Sources.Source.Mobile])
  sources: Sources.Source[];

  @doc("Дни недели, в которые действует скидка. Пустой массив — все дни.")
  daysOfWeek: DayOfWeek[];

  @doc("Время суток, в которое действует скидка. Пустой массив — весь день.")
  timeRanges: TimeRange[];

  @doc("Скидка действует, только если дата создания заказа совпадает с датой заказа")
  sameDayOnly: boolean;

  @doc("Календарный период действия. `null` — без ограничения по датам.")
  period: DatePeriod | null;

  @doc("За сколько часов до начала заказа активируется скидка. `null` — без ограничения.")
  @example(24)
  @minValue(1)
  hoursBeforeStart: int32 | null;

  @doc("Скидка действует только на дополнительные позиции заказа")
  additionalPositionsOnly: boolean;
}

@doc("Клиенты, которым разрешено использовать скидку")
model DiscountAudience {
  @doc("Разрешённые клиенты. Если список не пуст, скидка считается персональной. Пустой массив — все клиенты.")
  allowedClientIds: Primitives.Uuid[];
}
