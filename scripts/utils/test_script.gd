extends Node



func _ready():
	print(GridHelper.world_to_grid(Vector2(50, 50)))  # Should print (1, 1)
	print(GridHelper.grid_to_world(Vector2i(2, 3)))  # Should print (64, 96)
	print(GridHelper.snap_to_grid(Vector2(55, 47)))  # Should print (64, 32)
