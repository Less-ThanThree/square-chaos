extends Control

@onready var plate = $ColorRect
var switch = false
signal click

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
	print("Current Matrix", PlayerStatus.getCurrentLevelField())
	PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getPlayerLevelField(), PlayerStatus.getCurrentLevelField()))
	click.emit()

#func _on_on_click_toggled(button_pressed):
#	if button_pressed: 
#		plate.set_color(Color(0,0,0))
#	else: 
#		plate.set_color(Color(1,1,1))
