class_name Enemy
extends Actor

func _ready() -> void:
	super()
 
func _on_hurtbox_recieved_damage(area: Hitbox) -> void:
	if area is VacuumArea and state_machine.current_state_name != "Vacuumed":
		state_machine.set_state("Vacuumed", {
			"vacuum_attract_target": area.entity,
			"vacuum_attract_area": area as VacuumArea,
		}) 

func _physics_process(delta: float) -> void:
	$Label.text = $StateMachine.current_state_name
