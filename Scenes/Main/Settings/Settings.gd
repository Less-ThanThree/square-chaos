extends Control

@onready var weightBuffInput = $BoxContainer/ColorRect/WeightBuff
@onready var timeGameInput = $BoxContainer/ColorRect/TimeGame
@onready var chanceFreezeInput = $BoxContainer/ColorRect/ChanceFreeze
@onready var chanceDefenseInput = $BoxContainer/ColorRect/ChanceDefense
@onready var chanceGoldInput = $BoxContainer/ColorRect/ChanceGold
@onready var constantDBFInput = $BoxContainer/ColorRect/ConstantDBF
@onready var startStageInput = $BoxContainer/ColorRect/StartStage

func _ready():
	weightBuffInput.text = str(PlayerStatus.weightMatrixGenerationSize).pad_decimals(2)
	timeGameInput.text = str(PlayerStatus.getGlobalTimer()).pad_decimals(2)
	chanceFreezeInput.text = str(ProbabilityBank.chanceFreezePlate).pad_decimals(2)
	chanceDefenseInput.text = str(ProbabilityBank.chanceDefensePlate).pad_decimals(2)
	chanceGoldInput.text = str(ProbabilityBank.chanceGoldPlate).pad_decimals(2)
	constantDBFInput.text = str(ProbabilityBank.PROCENTDBF).pad_decimals(2)
	startStageInput.text = str(PlayerStatus.getCurrentPlayerStage())

func _on_to_menu_pressed():
		get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")

func _on_set_settings_pressed():
	PlayerStatus.weightMatrixGenerationSize = float(weightBuffInput.text)
	PlayerStatus.setGlobalTimer(float(timeGameInput.text))
	ProbabilityBank.chanceFreezePlate = float(chanceFreezeInput.text)
	ProbabilityBank.chanceDefensePlate = float(chanceDefenseInput.text)
	ProbabilityBank.chanceGoldPlate = float(chanceGoldInput.text)
	ProbabilityBank.PROCENTDBF = float(constantDBFInput.text)
	PlayerStatus.setCurrentPlayerStage(int(startStageInput.text))

