class_name VacuumableComponent
extends Node2D

@export var vacuum_acceleration = 400
@export var vacuum_top_speed = 4000
@export var finish_distance = 16

signal finished

var entity: Entity
var target: Node2D = null
var vacuum_speed: float = 0.0

var active: bool = false

func _ready() -> void:
	assert(get_parent() is Entity, "Parent isn't an Entity")
	entity = get_parent()

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	var direction = entity.global_position.direction_to(target.global_position)
	
	vacuum_speed = min(vacuum_speed + vacuum_acceleration * delta, vacuum_top_speed)
	entity.velocity = direction * vacuum_speed
	
	if entity.global_position.distance_to(target.global_position) < finish_distance:
		entity.velocity = Vector2.ZERO
		deactivate()
		finished.emit()
	
	entity.move_and_slide()

func activate(new_target: Node2D):
	active = true
	target = new_target
	vacuum_speed = 0.0

func deactivate():
	active = false
	target = null
	vacuum_speed = 0.0

func has_target() -> bool:
	return target != null

func get_direction_to_target() -> Vector2:
	if not target:
		return Vector2.ZERO
	
	return (target.global_position - global_position).normalized()

func get_distance_to_target() -> float:
	if not target:
		return INF
	
	return (target.global_position - global_position).length()
