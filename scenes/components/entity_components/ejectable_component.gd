class_name EjectableComponent
extends EntityComponent

@export var eject_speed := 400.0
@export var max_bounces: int = 0

signal finished()

var direction: Vector2 = Vector2.ZERO
var bounces: int = 0

func _ready() -> void:
	super()

func activate(direction_: Vector2):
	active = true
	direction = direction_.normalized()
	bounces = max_bounces

func deactivate():
	active = false
	finished.emit()

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	entity.velocity = direction * eject_speed
	entity.move_and_slide()
	
	var collision: KinematicCollision2D = entity.get_last_slide_collision()
	if collision:
		if bounces <= 0:
			deactivate()
		else:
			var normal: Vector2 = collision.get_normal()
			direction = direction.bounce(normal)
			bounces -= 1

func _on_wall_detector_body_entered(body: Node2D):
	pass
