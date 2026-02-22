## An Entity is a game object that can move and interact with the world.
class_name Entity
extends CharacterBody2D

var vacuum_attract_target: Entity
var state_machine: StateMachine

func _ready() -> void:
	var node = get_node_or_null("StateMachine")
	if node and node is StateMachine:
		state_machine = node
