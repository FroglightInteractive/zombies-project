extends PlayerState

@export var visuals: StackedAnimatedSprite

@export var vacuum: Node2D
@export var vacuum_area: VacuumArea
@export var vacuum_particles: CPUParticles2D
@export var vacuum_dust_particles: CPUParticles2D

func _ready() -> void:
	super()

func _on_enter_state():
	visuals.play("open_mouth")
	await visuals.animation_finished
	if is_in_state:
		visuals.play("inhaling")
	
	vacuum_area.process_mode = Node.PROCESS_MODE_INHERIT

func _on_exit_state():
	vacuum_particles.emitting = false
	vacuum_dust_particles.emitting = false
	
	vacuum_area.process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(delta: float) -> void:
	super(delta)
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - player.global_position).normalized()
	player.set_aim_direction(direction)
	player.walk_direction = direction
	vacuum.rotation = player.aim_angle
	
	vacuum_particles.emitting = true
	vacuum_dust_particles.emitting = true
	
	visuals.flip_h = player.aim_direction.x < 0
	
	if Input.is_action_just_released("game_action"):
		state_machine.set_state("Idle")
		visuals.play("close_mouth")
	
	if Input.is_action_just_pressed("game_dash"):
		state_machine.set_state("Rolling")
	
	player.move_and_slide()
