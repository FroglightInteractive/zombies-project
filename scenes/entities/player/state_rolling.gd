extends PlayerState

@export var visuals: StackedAnimatedSprite
@export var dust_particles: CPUParticles2D

const SPEED = 300.0
const DURATION = 0.3

var time = 0.0

func _ready() -> void:
	super()

func _on_enter_state(params: Dictionary = {}):
	super(params)
	time = DURATION

func _on_exit_state():
	super()
	visuals.rotation = 0.0
	dust_particles.emitting = false

func _physics_process(delta: float) -> void:
	super(delta)
	
	player.velocity = player.walk_direction * SPEED
	player.move_and_slide()
	
	dust_particles.emitting = true
	
	var sign = 1
	if player.walk_direction.x < 0:
		sign = -1
	visuals.rotation += sign * delta * (TAU /DURATION)
	
	time = max(0.0, time - delta)
	if time <= 0.0:
		state_machine.set_state("Walking")
	
