extends EnemyState

@export var inhalable: Inhalable

func _on_enter_state():
	# TODO disable damage when in this state
	pass

func _physics_process(delta: float) -> void:
	super()
	
