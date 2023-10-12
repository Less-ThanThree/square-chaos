extends Node

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

# Size - размер матрицы, maxGeneratorPlate - максимальное количество плит в матрице
func generateMatrixLevel(size: int, maxGeneratePlate: int) -> Array:
	var sumPlate = 0
	var matrixTemplate: Array
	PlayerStatus.setPlayerLevelField([])
	PlayerStatus.setCurrentLevelField([])
	
	match size:
		2:
			matrixTemplate = matrixTemplateX2.duplicate(true)
			PlayerStatus.setPlayerLevelField(matrixTemplateX2.duplicate(true))
		3:
			matrixTemplate = matrixTemplateX3.duplicate(true)
			PlayerStatus.setPlayerLevelField(matrixTemplateX3.duplicate(true))
		4:
			matrixTemplate = matrixTemplateX4.duplicate(true)
			PlayerStatus.setPlayerLevelField(matrixTemplateX4.duplicate(true))
	
	for x in matrixTemplate.size():
		var plateInRow = randi_range(0, matrixTemplate.size())
		for y in matrixTemplate[x].size():
			if randi_range(0, 1) == 1 && sumPlate <= maxGeneratePlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1
	PlayerStatus.setCurrentLevelField(matrixTemplate)
	PlayerStatus.setCompareMatrix(false)
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
