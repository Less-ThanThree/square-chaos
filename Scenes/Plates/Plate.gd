extends Control

@onready var plate = $ColorRect
var switch = false

func _on_on_click_pressed():
	var buttonInfo = self.name.split('_', true, 3)
	
	if switch:
		plate.set_color(Color(1,1,1))
		switch = false
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 0)
	else:
		plate.set_color(Color(0,0,0))
		switch = true
		GeneratorLevel.updateMatrix(int(buttonInfo[1]), int(buttonInfo[2]), 1)
	print("Player Matrix", PlayerStatus.getPlayerLevelField())
	print("Matrix 1", PlayerStatus.getCurrentLevelField(0))
	print("Matrix 2", PlayerStatus.getCurrentLevelField(1))
	if PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(0),PlayerStatus.getPlayerLevelField())):
		print('Compare 1')
		PlayerStatus.setCurrentLevelField()
	elif PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(1),PlayerStatus.getPlayerLevelField())):
		print("Compare 2")
		PlayerStatus.setCurrentLevelField()
