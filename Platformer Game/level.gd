extends Node2D

@export var level_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("level " + str(level_num) + " ready!")
	set_gems_label()
	for gem in $Gems.get_children():
		gem.gem_collected.connect(_on_gem_collected)

func _on_gem_collected():
	set_gems_label()

func set_gems_label():
	$HUD/GemsLabel.text = "Gems: " + str(Global.gems_collected)

func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)
