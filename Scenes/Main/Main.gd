extends Node

func _ready():
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Game.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Settings/Settings.tscn")
