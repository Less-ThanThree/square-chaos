extends Node

@onready var levelNoPath = preload("res://Scenes/Game/GameNoPath.tscn")
@onready var levelWithPath = preload("res://Scenes/Game/GameWithPath.tscn")
@onready var timerCheckStageWithPath = $TimerCheckStageWithPath
@onready var timerCheckStageNoPath = $TimerCheckStageNoPath
@onready var isErrorRect = $isErrorFlash

var currentLevel

var tween:		 	Tween
var colorError: 	Color = Color(0.608, 0.055, 0, 0)
var colorErrorEnd: 	Color = Color(0.608, 0.055, 0, 1)

func _ready():
	PlayerStatus.onReadyDefaultSettings()
	currentLevel = levelNoPath.instantiate()
	self.add_child(currentLevel)
	
	isErrorRect.color = colorError

func _process(delta):
	if PlayerStatus.getGlobalTimer() <= 0.9:
		get_tree().change_scene_to_file("res://Scenes/Main/EndGame.tscn")
	
	if PlayerStatus.getIsErrorPlate():
		animatedFlash()

func animatedFlash():
	tween = get_tree().create_tween()
	tween.tween_property(isErrorRect, "color", colorErrorEnd, 0.2)
	tween.tween_property(isErrorRect, "color", colorError, 0.2)
	tween.play()

func _on_timer_check_stage_with_path_timeout():
	if PlayerStatus.getPath():
		self.remove_child(currentLevel)
		PlayerStatus.setCurrentLevelField()
		currentLevel = levelWithPath.instantiate()
		self.add_child(currentLevel)
		timerCheckStageWithPath.stop()
		timerCheckStageNoPath.start()
		PlayerStatus.LevelsCount = 2

func _on_timer_check_stage_no_path_timeout():
	if PlayerStatus.getPath() == false:
		self.remove_child(currentLevel)
		PlayerStatus.setCurrentLevelField()
		PlayerStatus.LevelsCount = 1
		currentLevel = levelNoPath.instantiate()
		self.add_child(currentLevel)
		timerCheckStageWithPath.start()
		timerCheckStageNoPath.stop()
