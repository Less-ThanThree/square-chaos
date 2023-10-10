extends Control

@onready var plate = load("res://Scenes/Plates/Plate.tscn")
@onready var gridLevel = $GridContainer
var arrayPlateIndexs = []

func _ready():
	pass

func generateLevel(matrix) -> void:
	gridLevel.set_columns(matrix.size())
	var xCounter = -1
	var yCounter = -1
	
	for x in matrix.size():
		xCounter += 1
		yCounter = -1
		for y in matrix[x].size():
			yCounter += 1
			var plate_instance = plate.instantiate()
			plate_instance.set_name("plate_{x}_{y}_{val}".format({"x": xCounter, "y": yCounter, "val": matrix[x][y]}))
			print(plate_instance.get_name())
			gridLevel.add_child(plate_instance)
#	gridLevel.get_node('plate_0_0').get_node("ColorRect").set_color(Color(0, 0, 0))

func _on_node_2d_ready_level():
	generateLevel(PlayerStatus.getPlayerLevelField())

#func isClick():
	


