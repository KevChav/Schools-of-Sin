class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

const BASE_STYLE := preload("res://scenes/card_ui/card_base_style.tres")
const DRAG_STYLE := preload("res://scenes/card_ui/card_dragging_style.tres")
const HOVER_STYLE := preload("res://scenes/card_ui/card_hover_style.tres")
const EXIT_STYLE := preload("res://scenes/card_ui/card_exit_style.tres")

@export var card: Card : set = _set_card #update the Card visuals by getting data from card.gd
@onready var panel = $Panel
@onready var cost = $Cost
@onready var icon = $Icon
@onready var drop_point_detector = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []

var parent: Control
var tween: Tween


func _ready() -> void:
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
	
func _set_card(value: Card) -> void: #updates card ui with correct info 
	if not is_node_ready():
		await ready
	card = value
	cost.text = str(card.cost)
	icon.texture = card.icon

func _on_drop_point_detector_area_entered(area: Area2D):
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area):
	targets.erase(area)
