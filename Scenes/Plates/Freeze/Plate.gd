extends Control

@onready var plate = $ColorRect
@onready var timerTap = $TimeTap
@onready var button = $OnClick

var tween: Tween
var switch: bool 			= false
var timeWaitTap: float 		= 0.16
var noMore: bool			= false
var freezDone: bool			= false
var isDown: bool			= false
var colorStart: Color		= Color(0.075, 0.455, 0.894)
var colorEnd: Color			= Color(0, 0, 0)
var colorOn: Color			= Color(1, 1, 1)
var buttonInfo: PackedStringArray

func _ready():
	timerTap.wait_time = timeWaitTap
	timerTap.one_shot = true
	timerTap.autostart = false
	plate.color = colorStart
	tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", colorEnd, timeWaitTap - 0.05)
	tween.stop()
	buttonInfo = self.name.split('_', true, 3)

func _process(delta):
	if noMore:
		freezDone = true
	
	if !tween.is_valid():
		tween.stop()
		freezDone = true
		
	if isDown && timerTap.is_stopped():
		noMore = true
		tween.stop()
	if !isDown && !timerTap.is_stopped():
		timerTap.stop()
		tween.stop()
		$ColorRect.color = colorStart

func _on_on_click_button_down():
	if !freezDone:
		isDown = true
		timerTap.start()
		tween.play()

func _on_on_click_button_up():
	if !freezDone:
		isDown = false
		noMore = false
	else:
		getPlateActive()

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
			print("Compare 2")
			PlayerStatus.setCurrentLevelField()

func isErrorFieldActive(playerFiled: Array, levelFiled: Array, x: int, y: int) -> bool:
	if playerFiled[x][y] == 1:
		if playerFiled[x][y] != levelFiled[x][y]:
			return true
	return false
