extends VacuumedState

@export var sprite: Sprite2D

func _on_enter_state(params: Dictionary = {}):
	super(params)
	sprite.modulate = Color.RED

func _on_exit_state():
	super()
	sprite.modulate = Color.WHITE
