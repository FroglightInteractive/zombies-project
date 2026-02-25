class_name Enemy
extends Actor

func _ready() -> void:
	super()

func _on_hurtbox_recieved_damage(area: Hitbox) -> void:
	pass

func _physics_process(delta: float) -> void:
	$Label.text = $StateMachine.current_state_name
