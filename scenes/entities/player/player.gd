class_name Player
extends Actor

@export var block_inputs := false

@export_category("Imports")
@export var visuals: StackedAnimatedSprite
@export var vacuum_area: VacuumArea 
@export var vacuum_particles: CPUParticles2D
@export var vacuum_dust_particles: CPUParticles2D
@export var capturer_component: CapturerComponent

@export_category("Vacuum")
@export var vacuum_range = 16*12
@export var vacuum_width = 20
@export var vacuum_visual_range_offset = 8
@export var vacuum_visual_width = 12
@export var vacuum_visual_particles_speed_min = 1000
@export var vacuum_visual_particles_speed_max = 1200

@export_category("Visuals")
@export var squash_speed = 4.0
@export var post_capture_squash = 1.5

var user_index = 0

var squash = 1.0

var walk_direction := Vector2.RIGHT
var aim_direction := Vector2.RIGHT
var aim_angle := 0.0

func _ready() -> void:
	super()
	setup_vacuum_area()

func setup_vacuum_area():
	vacuum_area.disable()
	
	var shape: CollisionShape2D = vacuum_area.get_node("CollisionShape2D")
	var rect_shape: RectangleShape2D = shape.shape
	rect_shape.size.x = vacuum_range
	rect_shape.size.y = vacuum_width
	shape.position.x = vacuum_range / 2.0
	
	var visual_range = vacuum_range - vacuum_visual_range_offset
	vacuum_particles.position.x = visual_range
	vacuum_particles.emission_rect_extents.x = 8
	vacuum_particles.emission_rect_extents.y = vacuum_visual_width * 0.5
	vacuum_particles.initial_velocity_min = vacuum_visual_particles_speed_min
	vacuum_particles.initial_velocity_max = vacuum_visual_particles_speed_max
	vacuum_particles.lifetime = visual_range / vacuum_particles.initial_velocity_max
	vacuum_particles.emitting = false
	
	vacuum_dust_particles.emitting = false

func _process(delta: float) -> void:
	if has_captured_entity():
		visuals.set_layer_visibility("FaceSprite", false)
		visuals.set_layer_visibility("FaceSpriteMouthFull", true)
	else:
		visuals.set_layer_visibility("FaceSprite", true)
		visuals.set_layer_visibility("FaceSpriteMouthFull", false)
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	set_aim_direction(direction)
	
	squash = move_toward(squash, 1.0, squash_speed * delta)
	if abs(squash - 1.0) < 0.01:
		squash = 1.0
	visuals.scale = Vector2(squash, 1/squash)
	
	$ProgressBar.max_value = $LifeComponent.max_life
	$ProgressBar.value = $LifeComponent.life
	$Label.text = str($LifeComponent.life) + " / " + str($LifeComponent.max_life)

func set_aim_direction(direction: Vector2):
	aim_direction = Vector2(direction).normalized()
	aim_angle = direction.angle()

func set_aim_angle(angle: float):
	set_aim_direction(Vector2.RIGHT.rotated(angle))

func has_captured_entity():
	return capturer_component.has_captured_entity()

func exhale():
	capturer_component.uncapture(aim_direction)
	state_machine.set_state("Spitting")

func _on_capturer_component_captured(new_captured_entity: Entity) -> void:
	state_machine.set_state("Idle")
	visuals.play("close_mouth")
	set_squash(post_capture_squash)

func set_squash(value: float):
	squash = value

func get_vector(negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName, deadzone: float = -1.0) -> Vector2:
	if block_inputs:
		return Vector2.ZERO
	return Input.get_vector(negative_x, positive_x, negative_y, positive_y, deadzone)

func is_action_just_pressed(action: StringName, exact_match: bool = false) -> bool:
	if block_inputs:
		return false
	return Input.is_action_just_pressed(action, exact_match)

func is_action_just_released(action: StringName, exact_match: bool = false) -> bool:
	if block_inputs:
		return false
	return Input.is_action_just_released(action, exact_match)
