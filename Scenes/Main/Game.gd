extends Node

@onready var levelNoPath = preload("res://Scenes/Game/GameNoPath.tscn")
@onready var levelWithPath = preload("res://Scenes/Game/GameWithPath.tscn")
@onready var timer = $Timer
var currentLevel

func _ready():
	currentLevel = levelNoPath.instantiate()
	self.add_child(currentLevel)

func _on_timer_timeout():
	if PlayerStatus.getPath():
		self.remove_child(currentLevel)
		currentLevel = levelWithPath.instantiate()
		self.add_child(currentLevel)
		timer.stop()
		PlayerStatus.LevelsCount = 2
		
