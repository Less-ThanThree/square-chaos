extends Node

func _on_reload_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Game.tscn")

func _on_to_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
