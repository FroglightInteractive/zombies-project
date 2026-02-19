class_name Player
extends Actor

@export var inhale_range = 16*6
@export var inhale_width = 20
@export var inhale_visual_width = 12
@export var inhale_visual_particles_speed_min = 412
@export var inhale_visual_particles_speed_max = 512

var user_index = 0

var walk_direction := Vector2.RIGHT
var aim_direction := Vector2.RIGHT
var aim_angle := 0.0

@onready var inhale_area: Area2D = $InhaleArea

func _ready() -> void:
	setup_inhale_area()

func setup_inhale_area():
	var shape: CollisionShape2D = inhale_area.get_node("CollisionShape2D")
	var rect_shape: RectangleShape2D = shape.shape
	rect_shape.size.x = inhale_range
	rect_shape.size.y = inhale_width
	shape.position.x = inhale_range/2
	
	var inhale_particles = inhale_area.get_node("InhaleParticles")
	inhale_particles.position.x = inhale_range
	inhale_particles.emission_rect_extents.x = 8
	inhale_particles.emission_rect_extents.y = inhale_visual_width * 0.5
	inhale_particles.initial_velocity_min = inhale_visual_particles_speed_min
	inhale_particles.initial_velocity_max = inhale_visual_particles_speed_max
	inhale_particles.lifetime = inhale_range / inhale_particles.initial_velocity_max
	inhale_particles.emitting = false
	
	var inhale_dust_particles = inhale_area.get_node("InhaleDustParticles")
	inhale_dust_particles.emitting = false

func _process(delta: float) -> void:
	pass

func set_aim_direction(direction: Vector2):
	aim_direction = Vector2(direction).normalized()
	aim_angle = direction.angle()

func set_aim_angle(angle: float):
	set_aim_direction(Vector2.RIGHT.rotated(angle))
