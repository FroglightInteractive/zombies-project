class_name EjectedState
extends EntityState

@export var ejectable_component: EjectableComponent
@export var state_on_finished: StringName

func _ready() -> void:
	super()
	assert(ejectable_component, "ejectable_component is undefined")
	assert(state_on_finished, "state_on_finished is undefined")

func _physics_process(delta: float) -> void:
	super(delta)

func _on_enter_state(params: Dictionary = {}):
	assert(params.has("direction") and params["direction"], "No direction param")
	
	super(params)
	ejectable_component.activate(params["direction"])

func _on_exit_state():
	super()
	ejectable_component.deactivate()
