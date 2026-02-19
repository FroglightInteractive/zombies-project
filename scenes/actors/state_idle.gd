extends PlayerState

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	sprite.flip_h = player.walk_direction.x < 0
	
	if not sprite.is_playing():
		sprite.play("idle")
	
	var input_direction = Input.get_vector("game_left", "game_right", "game_up", "game_down")
	if input_direction:
		state_machine.set_state("Walking")
	
	if Input.is_action_just_pressed("game_action"):
		state_machine.set_state("Inhaling")
	
	if Input.is_action_just_pressed("game_secondary"):
		state_machine.set_state("Rolling")
	
	player.move_and_slide()

func _on_enter_state():
	sprite.play("enter_idle")

func _on_exit_state():
	pass
