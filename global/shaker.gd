extends Node


func shake(thing: Node2D, strength: float, duration: float = 0.3) -> void:
	if not thing:
		return
	var origin_pos := thing.position
	var shake_count := 15
	var tween := create_tween()
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))
		var target := origin_pos + strength * shake_offset
		if i % 2 == 0:
			target = origin_pos
		tween.tween_property(thing, "position", target, duration / float(shake_count))
		strength *= 0.75
	
	tween.finished.connect(func(): thing.position = origin_pos)
