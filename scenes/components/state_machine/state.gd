class_name State
extends AbstractState

var state_machine: StateMachine
var entity: Node2D

func _ready() -> void:
	assert(get_parent() is StateMachine)
	state_machine = get_parent()
	entity = state_machine.entity
