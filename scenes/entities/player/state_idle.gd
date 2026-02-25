extends PlayerState

@export var visuals: StackedAnimatedSprite

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	visuals.flip_h = player.walk_direction.x < 0
	
	if not visuals.is_playing():
		visuals.play("idle")
	
	var input_direction = player.get_vector("game_left", "game_right", "game_up", "game_down")
	if input_direction:
		state_machine.set_state("Walking")
	
	if player.is_action_just_pressed("game_action"):
		if player.has_captured_entity():
			player.exhale()
		else:
			state_machine.set_state("Inhaling")
	
	if player.is_action_just_pressed("game_dash"):
		state_machine.set_state("Rolling")
	
	player.move_and_slide()

func _on_enter_state(params: Dictionary = {}):
	super(params)
	visuals.play("enter_idle")

func _on_exit_state():
	super()
	pass
