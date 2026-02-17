extends State

@export var sprite: AnimatedSprite2D
@export var walk_particles: CPUParticles2D

var player: Player 

const ACCELERATION = 1500.0
const DECELERATION = 1000.0
const SPEED = 150.0

func _ready() -> void:
	super()
	player = entity as Player

func _physics_process(delta: float) -> void:
	move(delta)
	
	if Input.is_action_just_pressed("game_secondary"):
		state_machine.set_state("Rolling")
	
	sprite.flip_h = player.walk_direction.x < 0
	
	if player.velocity.length() > 4:
		sprite.play("walk")
		walk_particles.emitting = true
	else:
		sprite.play("default")
		walk_particles.emitting = false

func move(delta: float) -> void:
	var input_direction = Input.get_vector("game_left", "game_right", "game_up", "game_down")
	if input_direction:
		player.velocity = player.velocity.move_toward(input_direction*SPEED, ACCELERATION*delta)
		player.walk_direction = input_direction.normalized()
		
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, DECELERATION*delta)
	
	player.move_and_slide()
