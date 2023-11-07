extends Control

@onready var plate = $ColorRect
@onready var button = $OnClick

var tapDestroy: int 	= 2
var colorTap1: Color 	= Color(0.586, 0.101, 0.076)
var colorTap2: Color	= Color(0.29, 0.031, 0.02)
var colorEnd: Color		= Color(0, 0, 0)

func _ready():
	plate.color = colorTap1

func _on_on_click_button_up():
	tapDestroy -= 1
	match tapDestroy:
		0:
			plate.color = colorEnd
			button.disabled = true
		1:
			plate.color = colorTap2

