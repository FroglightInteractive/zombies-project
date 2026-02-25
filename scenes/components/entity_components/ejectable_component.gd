class_name EjectableComponent
extends EntityComponent

@export var eject_speed := 400.0

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	super()

func activate(direction_: Vector2):
	active = true
	direction = direction_.normalized()

func deactivate():
	active = false

func _physics_process(delta: float) -> void:
	if not active:
		return
	
	entity.velocity = direction * eject_speed
	entity.move_and_slide()
