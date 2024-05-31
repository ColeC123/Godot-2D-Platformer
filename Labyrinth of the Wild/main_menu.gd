extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("MainMenu Ready!")
	$Options/StartButton.grab_focus()
	if !OS.has_feature("pc"):
		$Options/FullscreenButton.hide()
		$Options/QuitButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_fullscreen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
