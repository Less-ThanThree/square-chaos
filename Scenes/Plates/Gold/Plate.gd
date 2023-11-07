extends Control

@onready var plate = $ColorRect

var colorGold: 		Color = Color(0.79, 0.79, 0)
var colorClicked:	Color = Color(0, 0, 0)

func _ready():
	plate.color = colorGold

func _on_on_click_pressed():
	plate.color = colorClicked
