class_name Player
extends Actor

@export var visuals: StackedAnimatedSprite

@export var vacuum_area: VacuumArea 
@export var vacuum_particles: CPUParticles2D
@export var vacuum_dust_particles: CPUParticles2D

@export var vacuum_range = 16*12
@export var vacuum_width = 20
@export var vacuum_visual_range_offset = 8
@export var vacuum_visual_width = 12
@export var vacuum_visual_particles_speed_min = 1000
@export var vacuum_visual_particles_speed_max = 1200

var user_index = 0

var walk_direction := Vector2.RIGHT
var aim_direction := Vector2.RIGHT
var aim_angle := 0.0

#var captured_entity: Entity = null
var captured_entity: bool = false

func _ready() -> void:
	super()
	setup_vacuum_area()

func setup_vacuum_area():
	var shape: CollisionShape2D = vacuum_area.get_node("CollisionShape2D")
	var rect_shape: RectangleShape2D = shape.shape
	rect_shape.size.x = vacuum_range
	rect_shape.size.y = vacuum_width
	shape.position.x = vacuum_range/2.0
	
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
	pass
	if Input.is_action_just_pressed("game_use"):
		captured_entity = not captured_entity
	
	if captured_entity:
		visuals.set_layer_visibility("FaceSprite", false)
		visuals.set_layer_visibility("FaceSpriteMouthFull", true)
	else:
		visuals.set_layer_visibility("FaceSprite", true)
		visuals.set_layer_visibility("FaceSpriteMouthFull", false)

func set_aim_direction(direction: Vector2):
	aim_direction = Vector2(direction).normalized()
	aim_angle = direction.angle()

func set_aim_angle(angle: float):
	set_aim_direction(Vector2.RIGHT.rotated(angle))

func has_captured_entity():
	#return captured_entity == null
	return captured_entity
