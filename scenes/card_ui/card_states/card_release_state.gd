extends CardState
#this script handles when a card is released
#you get here from the previous dragging script
var played: bool

func enter() -> void:
	played = false
	if not card_ui.targets.is_empty(): #check if the card is in the zone
		played = true
		print("Play card for target(s)", card_ui.targets)
		#maybe this can find where to drop the card. Each spell slot can be the card_ui.targets
		
		
func on_input(_event: InputEvent) -> void:
	if played:
		var myX = card_ui.global_position.x
		card_ui.position = Vector2(myX, 75)
		return #if the card is in the zone we exit this script 
	transition_requested.emit(self, CardState.State.BASE) #card dropped out of zone
	#can only transition after entering the new state

