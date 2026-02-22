extends Actor
class_name Enemy

func _ready() -> void:
	super()
 
func _on_hurtbox_recieved_damage(area: Hitbox) -> void:
	if area is VacuumArea and state_machine.current_state_name != "Vacuumed":
		vacuum_attract_target = area.entity
		state_machine.set_state("Vacuumed") 
