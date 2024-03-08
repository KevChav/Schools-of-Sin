extends CardState
const DRAG_MIN := .05
var min_drag_time := false
func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLE)
	min_drag_time = false
	var threshold_timer := get_tree().create_timer(DRAG_MIN, false)
	threshold_timer.timeout.connect(func(): min_drag_time = true) #lets you drag for a moment before release
	
	
func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targetd()
	
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion: 
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif min_drag_time and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
		

