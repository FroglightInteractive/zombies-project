extends PlayerState

@export var sprite: AnimatedSprite2D
@export var dust_particles: CPUParticles2D

const SPEED = 300.0
const DURATION = 0.3

var time = 0.0

func _ready() -> void:
	super()

func _on_enter_state():
	time = DURATION
	dust_particles.emitting = true

func _on_exit_state():
	sprite.rotation = 0.0
	dust_particles.emitting = false

func _physics_process(delta: float) -> void:
	super(delta)
	
	player.velocity = player.walk_direction * SPEED
	player.move_and_slide()
	
	var sign = 1
	if player.walk_direction.x < 0:
		sign = -1
	sprite.rotation += sign * delta * (TAU /DURATION)
	
	time = max(0.0, time - delta)
	if time <= 0.0:
		state_machine.set_state("Walking")
	
	if Input.is_action_just_pressed("game_secondary"):
		state_machine.set_state("Rolling")
	
