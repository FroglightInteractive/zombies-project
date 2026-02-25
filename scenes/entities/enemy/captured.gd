extends CapturedState

func _on_enter_state(params: Dictionary = {}):
	super(params)
	
	entity.hide()

func _on_exit_state():
	super()
	
	entity.show()
