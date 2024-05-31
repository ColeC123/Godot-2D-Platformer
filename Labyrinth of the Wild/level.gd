extends Node2D

@export var level_num = 0

var door_level

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.level(level_num)
	set_gems_label()
	for gem in $Gems.get_children():
		gem.gem_collected.connect(_on_gem_collected)
	if level_num == 2:
		$platform1/AnimationPlayer.play("back_and_forth")
		$platform2/AnimationPlayer.play("back_and_forth")
		$platform3/AnimationPlayer.play("back_and_forth")
	if level_num == 3:
		$CampfireLight/CampfireSprite.play("default")
		$platform1/AnimationPlayer.play("slant_up_and_down")
		$platform1/CampfireLight2/CampfireSprite.play("default")
		$TorchLight2/TorchSprite.play("torch_flicker")
		$TorchLight/TorchSprite.play("torch_flicker")
		$CampfireLight2/CampfireSprite.play("default")
		$TorchLight3/TorchSprite.play("torch_flicker")
		$TorchLight4/TorchSprite.play("torch_flicker")
		$TorchLight5/TorchSprite.play("torch_flicker")
		$platform2/AnimationPlayer.play("back_and_forth")
		$platform3/AnimationPlayer.play("back_and_forth")
		$platform4/AnimationPlayer.play("back_and_forth")
		$platform5/AnimationPlayer.play("back_and_forth")
		$CampfireLight3/CampfireSprite.play("default")

func _on_gem_collected():
	set_gems_label()

func set_gems_label():
	$HUD.gems(Global.gems_collected)

func _on_door_player_entered(level):
	door_level = level
	call_deferred("change_level")
	
func _input(event):
	if event.is_action_pressed("reset_level"):
		get_tree().reload_current_scene.call_deferred()
		Global.gems_collected = 0
		set_gems_label()


func _on_trap_body_entered(body):
	if body.name == "Player":
		$TileMap.set_layer_enabled(1, false)


func _on_trap_body_exited(body):
	if body.name == "Player":
		$TileMap.set_layer_enabled(1, true)


func _on_swim_up_body_entered(body):
	if body.name == "Player":
		$Player.is_swimming.emit()


func _on_swim_up_body_exited(body):
	if body.name == "Player":
		$Player.is_swimming.emit()

func change_level():
	get_tree().change_scene_to_file(door_level)


func _on_speeder_body_entered(body):
	if body.name == "Player":
		$Player.is_speeding.emit($Speeder/CollisionShape2D.position.y - 21)


func _on_speeder_body_exited(body):
	if body.name == "Player":
		$Player.is_speeding.emit(0)


func _on_chest_body_entered(body):
	if body.name == "Player":
		$Player.lock_position.emit()
		$Chest/AnimatedSprite2D.play("open")
		$Chest/Timer.start()


func _on_timer_timeout():
	$TextureRect2.visible = true
	$TextureRect2/AnimationPlayer.play("fade_to_white")
	$TextureRect2/Timer2.start()


func _on_timer_2_timeout():	
	get_tree().change_scene_to_file("res://credits.tscn")
