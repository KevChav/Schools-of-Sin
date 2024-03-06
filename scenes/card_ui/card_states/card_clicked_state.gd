extends CardState

func enter() -> void:
	card_ui.drop_point_detector.monitoring = true #checking for collision to zone
	
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING) #switch to dragging
		
		
