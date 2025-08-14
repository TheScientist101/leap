extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


const PLATFORM_DISTANCE_Y = 45.0
const PLATFORM_SPREAD_X = 100.0
const PLATFORM_MIN_X = -200.0
const PLATFORM_MAX_X = 0.0

const PLATFORM_TILE_ID = Vector2i(0, 0)

var last_generated_y = 0
var last_generated_x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_y = int($"../Player".position.y)
	if current_y % 2 == 1:
		current_y += 1
	while last_generated_y - PLATFORM_DISTANCE_Y > current_y:
		last_generated_y -= PLATFORM_DISTANCE_Y

		var platform_x = randf_range(max(last_generated_x - PLATFORM_SPREAD_X, PLATFORM_MIN_X), min(last_generated_x + PLATFORM_SPREAD_X, PLATFORM_MAX_X))
		var tile_pos = local_to_map(Vector2(platform_x, last_generated_y))

		print(tile_pos)
		set_cell(tile_pos, 0, PLATFORM_TILE_ID)
