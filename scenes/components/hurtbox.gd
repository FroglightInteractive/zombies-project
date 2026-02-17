extends Area2D
class_name Hurtbox

@export var life_component: LifeComponent
## Whether to ignore sibling hitboxes 
@export var ignore_sibling_hitboxes := true
signal recieved_damage(area: Hitbox)

func _ready() -> void:
	pass

func on_recieve_damage(hitbox: Hitbox):
	if not life_component.can_damage():
		return
	if life_component:
		life_component.damage(hitbox.damage)
	
	recieved_damage.emit(hitbox)

func is_hittable(hitbox: Hitbox):
	#if ignore_sibling_hitboxes and hitbox.get_parent() == get_parent():
		#return false
	return true
