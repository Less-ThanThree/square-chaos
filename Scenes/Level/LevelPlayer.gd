extends Control

@onready var plate = load("res://Scenes/Plates/Plate.tscn")
@onready var plateFreeze = load("res://Scenes/Plates/Freeze/Plate.tscn")
@onready var plateDefense = load("res://Scenes/Plates/Defense/Plate.tscn")
@onready var plateGold = load("res://Scenes/Plates/Gold/Plate.tscn")
@onready var gridLevel = $GridContainer
var allLevelsGenerate = 0
var currentStage

#func _ready():
#	GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
#	generateLevel(PlayerStatus.getPlayerLevelField())

func _process(delta):
	if PlayerStatus.getIsErrorPlate():
		PlayerStatus.setIsErrorPlate(false)
		currentStage = PlayerStatus.getCurrentStage()
		
		for node in gridLevel.get_children():
			gridLevel.remove_child(node)
			node.queue_free()
		
		PlayerStatus.setPlayerPointsMinus(ProbabilityBank.StateEffect.ERRORPOINTS * currentStage["MultiplePoints"])
		GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
		generateLevel(PlayerStatus.getPlayerLevelField())

# Генерация поля для игрока
func generateLevel(matrix) -> void:
	var xCounter = -1
	var yCounter = -1
	var fieldPlayerPlate: Array
	
	match PlayerStatus.currentSize:
		2:
			fieldPlayerPlate = GeneratorLevel.matrixTemplateX2.duplicate(true)
		3:
			fieldPlayerPlate = GeneratorLevel.matrixTemplateX3.duplicate(true)
		4:
			fieldPlayerPlate = GeneratorLevel.matrixTemplateX4.duplicate(true)
	
	if !PlayerStatus.getPath():
		fieldPlayerPlate = PlayerStatus.getCurrentLevelField(0).duplicate(true)
	elif PlayerStatus.LevelsCount >= 2:
		var matrix1 = PlayerStatus.getCurrentLevelField(0).duplicate(true)
		var matrix2 = PlayerStatus.getCurrentLevelField(1).duplicate(true)
		
		for x in matrix1.size():
			for y in matrix1[x]:
				if matrix1[x][y] == 1:
					fieldPlayerPlate[x][y] = 1
		
		for x in matrix2.size():
			for y in matrix2[x]:
				if matrix2[x][y] == 1:
					fieldPlayerPlate[x][y] = 1
	
	gridLevel.set_columns(matrix.size())
	for x in matrix.size():
		xCounter += 1
		yCounter = -1
		for y in matrix[x].size():
			yCounter += 1
			
			var plateNumber = getRandomPlate()
			var plate_instance
			
			if fieldPlayerPlate[x][y] == 0 && plateNumber != 0:
				plateNumber = 0
			
			match plateNumber:
				0:
					plate_instance = plate.instantiate()
				1:
					plate_instance = plateFreeze.instantiate()
				2:
					plate_instance = plateDefense.instantiate()
				3:
					plate_instance = plateGold.instantiate()

			plate_instance.set_name("plate_{x}_{y}_{val}".format({"x": xCounter, "y": yCounter, "val": matrix[x][y]}))
			gridLevel.add_child(plate_instance)

func _on_node_2d_ready_level():
	allLevelsGenerate += 1
	if PlayerStatus.LevelsCount == allLevelsGenerate:
		for node in gridLevel.get_children():
			gridLevel.remove_child(node)
			node.queue_free()
		GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
		generateLevel(PlayerStatus.getPlayerLevelField())
		allLevelsGenerate = 0
		PlayerStatus.setCompareMatrix(false)
		checkStage()
		GeneratorLevel.levelsGenerate = 0

func _on_node_2d_compare_level():
	for node in gridLevel.get_children():
		gridLevel.remove_child(node)
		node.queue_free()
	
	var currentStage = PlayerStatus.getCurrentStage()
	var currentBuff = PlayerStatus.getApplyBuffId()
	if !currentBuff.is_empty():
		if currentBuff[0] == 1 && currentBuff[1] == ProbabilityBank.StateBuff.DEBUFF:
			print("Minus PONINT!!!")
			minusPoints()
			PlayerStatus.clearApplyBuffId()
		else:
			addPoints()
			PlayerStatus.clearApplyBuffId()
	else:
		addPoints()

	if currentStage["LevelSize"] != 0:
		PlayerStatus.currentSize = currentStage["LevelSize"]
#	GeneratorLevel.generatePlayerMatrix(PlayerStatus.currentSize)
#	generateLevel(PlayerStatus.getPlayerLevelField())

# Проверка перехода стадии
func checkStage():
	var previosStage = PlayerStatus.getPreviosStage()
	var nextStage = PlayerStatus.getNextStage()
	var currentPlayerPoints = PlayerStatus.getPlayerPoints()
	var currentStage: Dictionary
	
	if currentPlayerPoints > nextStage["PointsStage"]:
		PlayerStatus.setCurrentPlayerStage(PlayerStatus.getCurrentPlayerStage() + 1)
	elif currentPlayerPoints < previosStage["PointsStage"]:
		PlayerStatus.setCurrentPlayerStage(PlayerStatus.getCurrentPlayerStage() - 1)
	
	PlayerStatus.setCurrentStage(PlayerStatus.getCurrentPlayerStage())
	PlayerStatus.setNextStage()
	PlayerStatus.setPreviosStage()
	
	print("CurrentStage: ", PlayerStatus.getCurrentPlayerStage())

	currentStage = PlayerStatus.getCurrentStage()
	print("Path ", currentStage["Path"])
	PlayerStatus.setPath(currentStage["Path"])

func addPoints():
	var currentStage = PlayerStatus.getCurrentStage()
	PlayerStatus.setPlayerPointsPlus(currentStage["PointsPerPasle"])

func minusPoints():
	var currentStage = PlayerStatus.getCurrentStage()
	PlayerStatus.setPlayerPointsMinus(currentStage["PointsPerPasle"])

func getRandomPlate() -> int:
	var plateFreeze = randf_range(0, 1)
	var plateDefense = randf_range(0, 1)
	var plateGold = randf_range(0, 1)
	
	if ProbabilityBank.chanceFreezePlate >= plateFreeze:
		return 1
	
	if ProbabilityBank.chanceDefensePlate >= plateDefense:
		return 2
	
	if ProbabilityBank.chanceGoldPlate >= plateGold:
		return 3
	
	return 0
	
