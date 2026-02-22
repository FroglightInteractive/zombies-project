class_name VacuumedState
extends EntityState

@export var vacuumable_component: VacuumableComponent
@export var state_on_finished: StringName

func _ready() -> void:
	super()
	vacuumable_component.finished.connect(_on_vacuumable_component_finished)

func _on_enter_state():
	super()
	assert(entity.vacuum_attract_target != null, "Entered VacuumedState with entity.vacuum_attract_target null")
	
	vacuumable_component.activate(entity.vacuum_attract_target)

func _on_vacuumable_component_finished():
	state_machine.set_state(state_on_finished)
