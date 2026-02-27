class_name EjectedState
extends EntityState

@export var ejectable_component: EjectableComponent
@export var state_on_finished: StringName
@export var particles: CPUParticles2D

func _ready() -> void:
	super()
	assert(ejectable_component, "ejectable_component is undefined")
	assert(state_on_finished, "state_on_finished is undefined")
	
	ejectable_component.finished.connect(_on_ejectable_component_finished)

func _physics_process(delta: float) -> void:
	super(delta)
	
	entity.rotate(20.0 * delta)

func _on_enter_state(params: Dictionary = {}):
	super(params)
	assert(params.has("direction") and params["direction"] != null, "No direction param")
	
	ejectable_component.activate(params["direction"])
	
	if particles:
		particles.emitting = true

func _on_exit_state():
	super()
	if ejectable_component.active:
		ejectable_component.deactivate()
	
	entity.rotation = 0.0
	
	if particles:
		particles.emitting = false

func _on_ejectable_component_finished():
	state_machine.set_state(state_on_finished)
