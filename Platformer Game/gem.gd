extends Area2D

signal gem_collected

func _on_body_entered(body):
	if body.name == "Player":
		Global.gems_collected += 1
		gem_collected.emit()
		queue_free()
