class_name Inhalable
extends Node2D

var target: Node2D = null

func set_target(new_target: Node2D) -> void:
	target = new_target

func clear_target() -> void:
	target = null

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
