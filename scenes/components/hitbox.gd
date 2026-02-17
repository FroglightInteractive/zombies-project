extends Area2D
class_name Hitbox

@export var enabled: bool = true :
	set(value):
		enabled = value
		if enabled:
			_enable()
		else:
			_disable()
@export var damage: float = 1.0

signal sent_damage(hurtbox: Hurtbox)
signal on_hurt_box_hit(hurtbox: Hurtbox)

func _ready() -> void:
	pass

func _disable() -> void:
	monitoring = false
	set_physics_process(false)

func _enable() -> void:
	monitoring = true
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area is Hurtbox and area.is_hittable(self):
			var hurtbox = area as Hurtbox
			hurtbox.on_recieve_damage(self)
			sent_damage.emit(hurtbox)
			on_hurt_box_hit.emit(hurtbox)
