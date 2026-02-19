class_name PlayerState
extends State

var deceleration = 1000.0

var player: Player

func _ready() -> void:
	super()
	player = state_machine.entity as Player

func _physics_process(delta: float) -> void:
	player.velocity = player.velocity.move_toward(Vector2.ZERO, deceleration*delta)
