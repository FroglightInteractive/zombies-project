## Area that can recieve damage from hitboxes.
extends Area2D
class_name Hurtbox

## Whether to deal damage on collision with a hitbox.
@export var deal_damage: bool = true

## Life component to deal damage to, if deal_damage is enabled.
@export var life_component: LifeComponent

## Whether to ignore sibling hitboxes. 
@export var ignore_sibling_hitboxes := true

## Emitted when entered in collision with a hitbox.
signal recieved_damage(area: Hitbox)

func _ready() -> void:
	pass

func on_recieve_damage(hitbox: Hitbox):
	if life_component and not life_component.can_damage():
		return
	if life_component:
		life_component.damage(hitbox.damage)
	
	recieved_damage.emit(hitbox)

func is_hittable(hitbox: Hitbox):
	if ignore_sibling_hitboxes and hitbox.get_parent() == get_parent():
		return false
	return true
