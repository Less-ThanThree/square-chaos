extends Control

@onready var plate = $ColorRect
@onready var button = $OnClick

var tapDestroy: int 	= 2
var switch: bool		= false
var colorTap1: Color 	= Color(0.586, 0.101, 0.076)
var colorTap2: Color	= Color(0.29, 0.031, 0.02)
var colorEnd: Color		= Color(0, 0, 0)
var colorOn: Color		= Color(1, 1, 1)
var buttonInfo: PackedStringArray

func _ready():
	plate.color = colorTap1
	buttonInfo = self.name.split('_', true, 3)

func _on_on_click_button_up():
	if tapDestroy != 0:
		tapDestroy -= 1
	
	match tapDestroy:
		0:
			plate.color = colorEnd
			getPlateActive()
		1:
			plate.color = colorTap2

func getPlateActive() -> void:
	if switch:
		plate.set_color(colorOn)
		switch = false
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 0)
	else:
		plate.set_color(colorEnd)
		switch = true
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 1)
		
		if PlayerStatus.getPath() == false && PlayerStatus.getIsErrorPlateBuffActive():
			PlayerStatus.setIsErrorPlate(isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(0), int(buttonInfo[1]), int(buttonInfo[2])))
		elif PlayerStatus.getPath() == true && PlayerStatus.getIsErrorPlateBuffActive():
			if isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(0), int(buttonInfo[1]), int(buttonInfo[2])) && isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(1), int(buttonInfo[1]), int(buttonInfo[2])):
				PlayerStatus.setIsErrorPlate(true)
		
	print("Player Matrix", PlayerStatus.getPlayerLevelField())
	print("Matrix 1", PlayerStatus.getCurrentLevelField(0))
	if PlayerStatus.LevelsCount >= 2:
		print("Matrix 2", PlayerStatus.getCurrentLevelField(1))
	if PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(0),PlayerStatus.getPlayerLevelField())):
		print('Compare 1')
		if PlayerStatus.getPath() == true:
			var currentBuff = PlayerStatus.getBuffStateCurrentLevel()
			print(currentBuff)
			ProbabilityBank.effectBuff(currentBuff[0][0], currentBuff[0][1])
			PlayerStatus.setApplyBuffId(currentBuff[0][0])
			PlayerStatus.setApplyBuffId(currentBuff[0][1])
			PlayerStatus.clearBuffStateCurrentLevel()
		PlayerStatus.setCurrentLevelField()
	elif PlayerStatus.LevelsCount >= 2:
		if PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(1),PlayerStatus.getPlayerLevelField())):
			var currentBuff = PlayerStatus.getBuffStateCurrentLevel()
			print(currentBuff)
			ProbabilityBank.effectBuff(currentBuff[1][0], currentBuff[1][1])
			PlayerStatus.setApplyBuffId(currentBuff[1][0])
			PlayerStatus.setApplyBuffId(currentBuff[1][1])
			PlayerStatus.clearBuffStateCurrentLevel()
			print("Compare 2")
			PlayerStatus.setCurrentLevelField()

func isErrorFieldActive(playerFiled: Array, levelFiled: Array, x: int, y: int) -> bool:
	if playerFiled[x][y] == 1:
		if playerFiled[x][y] != levelFiled[x][y]:
			return true
	return false
