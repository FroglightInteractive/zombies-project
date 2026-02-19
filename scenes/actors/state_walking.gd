extends PlayerState

@export var sprite: AnimatedSprite2D
@export var walk_particles: CPUParticles2D

const IDLE_VELOCITY_THRESHOLD = 4.0
const ACCELERATION = 1500.0
const SPEED = 150.0

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	
	var input_direction = Input.get_vector("game_left", "game_right", "game_up", "game_down")
	if input_direction:
		player.velocity = player.velocity.move_toward(input_direction*SPEED, ACCELERATION*delta)
		player.walk_direction = input_direction.normalized()
	player.move_and_slide()
	
	sprite.flip_h = player.walk_direction.x < 0
	walk_particles.emitting = true
	
	if not input_direction and player.velocity.length() < IDLE_VELOCITY_THRESHOLD:
		state_machine.set_state("Idle")
	
	if Input.is_action_just_pressed("game_action"):
		state_machine.set_state("Inhaling")
	
	if Input.is_action_just_pressed("game_secondary"):
		state_machine.set_state("Rolling")

func _on_enter_state():
	sprite.play("walk")

func _on_exit_state():
	walk_particles.emitting = false
