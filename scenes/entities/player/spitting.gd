extends PlayerState

@export var visuals: StackedAnimatedSprite
@export var duration = 0.25

var time = 0.0

func _ready() -> void:
	super()

func _on_enter_state(params: Dictionary = {}):
	super(params)
	time = duration
	visuals.play("spit")

func _on_exit_state():
	super()
	visuals.rotation = 0.0

func _physics_process(delta: float) -> void:
	super(delta)
	
	time -= delta
	if time <= 0.0:
		state_machine.set_state("Idle")
