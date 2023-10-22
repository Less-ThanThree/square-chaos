extends Control

@onready var labelPoints = $ContainerPoints/ColorRect/LabelPoints
var startPoint: float = 0.00

func _ready():
	labelPoints.text = str(startPoint).pad_decimals(2)

func _on_node_2d_compare_level():
	var playerPoints = PlayerStatus.getPlayerPoints()
	
	labelPoints.text = str(playerPoints).pad_decimals(2)

func _on_timer_points_timeout():
	var currentStage = PlayerStatus.getCurrentStage()
	PlayerStatus.setPlayerPointsMinus(currentStage["MultiPlePointsPerSecond"])
	
	var playerPoints = PlayerStatus.getPlayerPoints()
	labelPoints.text = str(playerPoints).pad_decimals(2)
