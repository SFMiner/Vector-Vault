extends Node

const GRID_SIZE := 32

static func world_to_grid(world_pos: Vector2) -> Vector2i:
	return Vector2i(world_pos / GRID_SIZE)

static func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos) * GRID_SIZE

static func snap_to_grid(world_pos: Vector2) -> Vector2:
	return grid_to_world(world_to_grid(world_pos))
