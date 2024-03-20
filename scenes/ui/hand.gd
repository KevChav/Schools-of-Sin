class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats

@onready var card_ui := preload("res://scenes/card_ui/card_ui.tscn")
var cards_played_this_turn := 0


func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	
func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats
	
func discarded_card(card: CardUI) -> void:
	card.queue_free() #delete card from the scene tree
	
func disable_hand() -> void: #this function prevents the player from playing cards at the end of their turn phase
	for card in get_children():
		card.disabled = true
		

func _on_card_played(_card: Card) -> void: 
	cards_played_this_turn += 1

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
