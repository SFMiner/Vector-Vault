extends Area2D

class_name PressurePlate

signal activated()
signal deactivated()

@export var required_weight: float = 1.0

var current_weight: float = 0.0
var is_active: bool = false
var plate_sprite: ColorRect
var tracked_blocks: Array = []

func _ready() -> void:
	plate_sprite = $PlateSprite

	# Set initial visual state
	_update_visual()

func _process(_delta: float) -> void:
	# Get all overlapping areas
	var overlapping_areas = get_overlapping_areas()
	var current_blocks = []
	var total_weight = 0.0

	# Check all overlapping areas for GeoBlocks
	for area in overlapping_areas:
		var parent = area.get_parent()
		if parent is GeoBlock:
			current_blocks.append(parent)
			total_weight += parent.scale.length()

	# Check direct overlaps with the physics space
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = $CollisionShape2D.shape
	query.transform = global_transform

	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_shape(query)

	total_weight = 0.0
	current_blocks = []

	for result in results:
		var collider = result.collider
		if collider is GeoBlock:
			if collider not in current_blocks:
				current_blocks.append(collider)
			total_weight += collider.scale.length()

	tracked_blocks = current_blocks
	current_weight = total_weight

	# Check activation state
	if current_weight >= required_weight and not is_active:
		is_active = true
		activated.emit()
		_update_visual()
	elif current_weight < required_weight and is_active:
		is_active = false
		deactivated.emit()
		_update_visual()

func _update_visual() -> void:
	if is_active:
		plate_sprite.modulate = Color(0.5, 1.0, 0.5, 1.0)  # Green when active
	else:
		plate_sprite.modulate = Color(0.7, 0.7, 0.7, 1.0)  # Gray when inactive
