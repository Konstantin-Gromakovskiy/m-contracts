namespace Sources;

@doc("Источник (интерфейс), в котором доступна сущность")
enum Source {
	@doc("Кабинет")
	Web: 0,

	@doc("Приложение")
	Mobile: 1,

	@doc("Виджет")
	Widget: 2,

	@doc("Каталог")
	Catalog: 7,
}
