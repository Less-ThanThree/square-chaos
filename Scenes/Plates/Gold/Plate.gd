extends Control

@onready var plate = $ColorRect

var switch: bool			= false
var countClick: int			= 0
var colorGold: Color		= Color(0.79, 0.79, 0)
var colorEnd: Color 		= Color(0, 0, 0)
var colorOn: Color			= Color(1, 1, 1)
var currentStage: Dictionary
var buttonInfo: PackedStringArray

func _ready():
	plate.color = colorGold
	buttonInfo = self.name.split('_', true, 3)

func _on_on_click_pressed():
	if switch:
		plate.set_color(colorOn)
		switch = false
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 0)
	else:
		plate.set_color(colorEnd)
		switch = true
		countClick += 1
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 1)
#		print("Player Matrix", PlayerStatus.getPlayerLevelField())
		if PlayerStatus.getPath() == false && PlayerStatus.getIsErrorPlateBuffActive():
			PlayerStatus.setIsErrorPlate(isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(0), int(buttonInfo[1]), int(buttonInfo[2])))
		elif PlayerStatus.getPath() == true && PlayerStatus.getIsErrorPlateBuffActive():
			if isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(0), int(buttonInfo[1]), int(buttonInfo[2])) && isErrorFieldActive(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField(1), int(buttonInfo[1]), int(buttonInfo[2])):
				PlayerStatus.setIsErrorPlate(true)
	
	if countClick == 1:
		currentStage = PlayerStatus.getCurrentStage()
		PlayerStatus.setPlayerPointsPlus(currentStage["MultiplePoints"] * 100)
	
#	print("Matrix 1", PlayerStatus.getCurrentLevelField(0))
#	if PlayerStatus.LevelsCount >= 2:
#		print("Matrix 2", PlayerStatus.getCurrentLevelField(1))
	if PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(0),PlayerStatus.getPlayerLevelField())):
#		print('Compare 1')
		if PlayerStatus.getPath() == true:
			var currentBuff = PlayerStatus.getBuffStateCurrentLevel()
			print(currentBuff)
			
			if currentBuff[0][1] == ProbabilityBank.StateBuff.DEBUFF && PlayerStatus.getIsDefenseBuffActive():
				PlayerStatus.minusPlayerDefenseCount(1)
			else:
				ProbabilityBank.effectBuff(currentBuff[0][0], currentBuff[0][1])
			
			PlayerStatus.setApplyBuffId(currentBuff[0][0])
			PlayerStatus.setApplyBuffId(currentBuff[0][1])
			PlayerStatus.clearBuffStateCurrentLevel()
		PlayerStatus.setCurrentLevelField()
	elif PlayerStatus.LevelsCount >= 2:
		if PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(1),PlayerStatus.getPlayerLevelField())):
			var currentBuff = PlayerStatus.getBuffStateCurrentLevel()
			print(currentBuff)
			
			if currentBuff[1][1] == ProbabilityBank.StateBuff.DEBUFF && PlayerStatus.getIsDefenseBuffActive():
				PlayerStatus.minusPlayerDefenseCount(1)
			else:
				ProbabilityBank.effectBuff(currentBuff[1][0], currentBuff[1][1])

			PlayerStatus.setApplyBuffId(currentBuff[1][0])
			PlayerStatus.setApplyBuffId(currentBuff[1][1])
			PlayerStatus.clearBuffStateCurrentLevel()
#			print("Compare 2")
			PlayerStatus.setCurrentLevelField()
	
func isErrorFieldActive(playerFiled: Array, levelFiled: Array, x: int, y: int) -> bool:
	if playerFiled[x][y] == 1:
		if playerFiled[x][y] != levelFiled[x][y]:
			return true
	return false
