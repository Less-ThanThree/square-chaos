extends Node

var levelsGenerate = 0

#var current_scene = null
#
#func _ready():
#	var root = get_tree().get_root()
#	current_scene = root.get_child(root.get_child_count() - 1)

var matrixTemplateX2 = [
	[0,0],
	[0,0],
]

var matrixTemplateX3 = [
	[0,0,0],
	[0,0,0],
	[0,0,0],
]

var matrixTemplateX4 = [
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0],
	[0,0,0,0],
]

func generatePlayerMatrix(size: int) -> void:
	match size:
		2:
			PlayerStatus.setPlayerLevelField(matrixTemplateX2.duplicate(true))
		3:
			PlayerStatus.setPlayerLevelField(matrixTemplateX3.duplicate(true))
		4:
			PlayerStatus.setPlayerLevelField(matrixTemplateX4.duplicate(true))

func generateMatrix(size: int, minGeneratePlate: int, maxGeneratePlate: int) -> Array:
	var sumPlate = 0
	var matrixTemplate: Array
	
	match size:
		2:
			matrixTemplate = matrixTemplateX2.duplicate(true)
		3:
			matrixTemplate = matrixTemplateX3.duplicate(true)
		4:
			matrixTemplate = matrixTemplateX4.duplicate(true)
	
	for x in matrixTemplate.size():
		for y in matrixTemplate[x].size():
			if randf_range(0, 1) >= PlayerStatus.weightMatrixGenerationSize && sumPlate <= maxGeneratePlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1
	
	while sumPlate < minGeneratePlate:
		sumPlate = 0
		matrixTemplate.clear()
		matrixTemplate = []
		for x in matrixTemplate.size():
			for y in matrixTemplate[x].size():
				if randf_range(0, 1) >= PlayerStatus.weightMatrixGenerationSize && sumPlate <= maxGeneratePlate:
					matrixTemplate[x][y] = 1
					sumPlate += 1
	levelsGenerate += 1
	
	return matrixTemplate
	
# Сравниваем матрицы 
func compareMatrix(matrix1: Array, matrix2: Array) -> bool:	
	for x in matrix1.size():
		for y in matrix1[x].size():
			if matrix1[x][y] != matrix2[x][y]:
				return false
	return true

# Обновляем матрицу positionX: x матрицы, positionY: y матрицы, val: значение (0,1)
func updateMatrix(positionX: int, positionY: int, val: int) -> void:
	var playerMatrix = PlayerStatus.getPlayerLevelField()
	playerMatrix[positionX][positionY] = val
	PlayerStatus.setPlayerLevelField(playerMatrix)

#func goto_scene(path):
#	call_deferred('_defferedGotoScene', path)
#
#func _defferedGotoScene(path):
#	current_scene.free()
#
#	var scene = ResourceLoader.load(path)
#	get_tree().get_root().add_child(current_scene)
#	get_tree().set_current_scene(current_scene)
	
	
