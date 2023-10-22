extends Control

@onready var plate = load("res://Scenes/Plates/Plate.tscn")
@onready var gridLevel = $GridContainer
var allLevelsGenerate = 0

func _ready():
	GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
	generateLevel(PlayerStatus.getPlayerLevelField())

# Генерация поля для игрока
func generateLevel(matrix) -> void:
	var xCounter = -1
	var yCounter = -1
	
	gridLevel.set_columns(matrix.size())
	for x in matrix.size():
		xCounter += 1
		yCounter = -1
		for y in matrix[x].size():
			yCounter += 1
			var plate_instance = plate.instantiate()
			plate_instance.set_name("plate_{x}_{y}_{val}".format({"x": xCounter, "y": yCounter, "val": matrix[x][y]}))
			gridLevel.add_child(plate_instance)

func _on_node_2d_ready_level():
	allLevelsGenerate += 1
	if PlayerStatus.LevelsCount == allLevelsGenerate:
		allLevelsGenerate = 0
		PlayerStatus.setCompareMatrix(false)
		addPoints()
		checkStage()

func _on_node_2d_compare_level():
	for node in gridLevel.get_children():
		gridLevel.remove_child(node)
		node.queue_free()
	GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
	generateLevel(PlayerStatus.getPlayerLevelField())

func checkStage():
	var previosStage = PlayerStatus.getPreviosStage()
	var nextStage = PlayerStatus.getNextStage()
	var currentPlayerPoints = PlayerStatus.getPlayerPoints()
	
	if currentPlayerPoints > nextStage["PointsStage"]:
		PlayerStatus.setCurrentPlayerStage(PlayerStatus.getCurrentPlayerStage() + 1)
	elif currentPlayerPoints < nextStage["PointsStage"]:
		PlayerStatus.setCurrentStage(PlayerStatus.getCurrentPlayerStage() - 1)
	
	PlayerStatus.setCurrentStage(PlayerStatus.getCurrentPlayerStage())
	PlayerStatus.setNextStage()
	PlayerStatus.setPreviosStage()
	
	print("CurrentStage: ", PlayerStatus.getCurrentPlayerStage())

func addPoints():
	var currentStage = PlayerStatus.getCurrentStage()
	PlayerStatus.setPlayerPointsPlus(currentStage["PointsPerPasle"])
