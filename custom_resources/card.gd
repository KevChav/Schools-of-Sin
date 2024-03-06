class_name Card
extends Resource
enum Type {ATTACK, DEFEND, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE, NEXT, PREV}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String


func is_single_targetd() -> bool:
	return target == Target.SINGLE_ENEMY
	
