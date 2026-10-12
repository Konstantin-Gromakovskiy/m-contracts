import "./primitives.tsp";

namespace Files;

@doc("Числовой тип файла.")
enum FileType {
  @doc("Иконка файла.")
  Ico: 0,
  @doc("Изображение.")
  Img: 1,
  @doc("Видео.")
  Vid: 2,
  @doc("Документ.")
  Doc: 3,
}

@doc("Метаданные файла, сохраненного в файловом хранилище.")
@example(#{
  key: "c931680171fc4f91bf491c36ff903352/QR_Картофельное поле_20260520_fe1158fa5c1d4356a0e72f173f7cad02.png",
  name: "QR_Картофельное поле.png",
  parentId: "c9316801-71fc-4f91-bf49-1c36ff903352",
  size: 6570,
  contentType: "image/png",
  lastModified: utcDateTime.fromISO("2026-05-20T16:05:29.120453Z"),
  url: "/testvedro/c931680171fc4f91bf491c36ff903352/qr-potato-field_20260520_fe1158fa5c1d4356a0e72f173f7cad02.png",
  priority: 4,
  fileType: FileType.Img,
  resourceId: "fe1158fa-5c1d-4356-a0e7-2f173f7cad02",
  parentType: "Room",
  bucketName: "testvedro",
})
model FileDto<T extends FileType = FileType> {
  @doc("Ключ файла в файловом хранилище.")
  key: string;
  @doc("Имя файла.")
  name: string;
  @doc("Идентификатор сущности, к которой прикреплен файл.")
  parentId: Primitives.Uuid;
  @doc("Размер файла в байтах.")
  size: uint64;
  @doc("MIME-тип файла.")
  contentType: string;
  @doc("Дата и время последнего изменения файла.")
  lastModified: utcDateTime;
  @doc("URL файла.")
  @format("uri-reference")
  url: string;
  @doc("Приоритет файла среди файлов одной сущности.")
  priority: uint32;
  @doc("Тип файла.")
  fileType: T;
  @doc("Идентификатор ресурса в файловом хранилище.")
  resourceId: Primitives.Uuid;
  @doc("Тип родительской сущности.")
  parentType: string;
  @doc("Имя bucket в файловом хранилище.")
  bucketName: string;
}
