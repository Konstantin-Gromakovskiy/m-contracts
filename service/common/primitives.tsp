namespace Primitives;

@format("uuid")
@mediaTypeHint("application/json")
@example("56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c")
scalar Uuid extends string;

@doc("Цвет в Hex-формате `#RRGGBB`.")
@format("hex-color")
@pattern("^#[0-9A-Fa-f]{6}$")
scalar HexColor extends string;
