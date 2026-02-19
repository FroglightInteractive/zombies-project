extends PlayerState

@export var sprite: AnimatedSprite2D
@export var inhale_area: Area2D
@export var inhale_particles: CPUParticles2D
@export var inhale_dust_particles: CPUParticles2D

func _ready() -> void:
	super()

func _on_enter_state():
	sprite.play("open_mouth")
	await sprite.animation_finished
	if is_in_state:
		sprite.play("inhaling")

func _on_exit_state():
	inhale_particles.emitting = false
	inhale_dust_particles.emitting = false

func _physics_process(delta: float) -> void:
	super(delta)
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - player.global_position).normalized()
	player.set_aim_direction(direction)
	player.walk_direction = direction
	inhale_area.rotation = player.aim_angle
	
	inhale_particles.emitting = true
	inhale_dust_particles.emitting = true
	
	sprite.flip_h = player.aim_direction.x < 0
	
	if Input.is_action_just_released("game_action"):
		state_machine.set_state("Idle")
		sprite.play("close_mouth")
	
	player.move_and_slide()
