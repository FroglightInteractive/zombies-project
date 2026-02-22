class_name EntityState
extends State

@export var deceleration = 1000.0

var entity: Entity

func _ready() -> void:
	super()
	entity = state_machine.entity

func _physics_process(delta: float) -> void:
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, deceleration*delta)
