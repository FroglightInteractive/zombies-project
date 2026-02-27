class_name Enemy
extends Actor

@export var hitbox: Hitbox

func _ready() -> void:
	super()
	
	hitbox.enabled = false

func _on_hurtbox_recieved_damage(area: Hitbox) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
