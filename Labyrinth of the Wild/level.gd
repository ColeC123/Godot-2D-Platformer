extends Node2D

@export var level_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.level(level_num)
	set_gems_label()
	for gem in $Gems.get_children():
		gem.gem_collected.connect(_on_gem_collected)

func _on_gem_collected():
	set_gems_label()

func set_gems_label():
	$HUD.gems(Global.gems_collected)

func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)
	
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


