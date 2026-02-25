extends EnemyState

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	enemy.move_and_slide()
