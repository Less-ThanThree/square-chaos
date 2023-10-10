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
	var matrixTemplate
	
	match size:
		2:
			matrixTemplate = matrixTemplateX2
			PlayerStatus.setPlayerLevelField(matrixTemplateX2)
		3:
			matrixTemplate = matrixTemplateX3
			PlayerStatus.setPlayerLevelField(matrixTemplateX3)
		4:
			matrixTemplate = matrixTemplateX4
			PlayerStatus.setPlayerLevelField(matrixTemplateX4)
	
	for x in matrixTemplate.size():
		var plateInRow = randi_range(0, matrixTemplate.size())
		for y in matrixTemplate[x].size():
			if randi_range(0, 1) == 1 && sumPlate <= maxGeneratePlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1
	PlayerStatus.setCurrentLevelField(matrixTemplate)
	return matrixTemplate

func compareMatrix(matrix1: Array, matrix2: Array) -> bool:
	for x in matrix1.size():
		for y in matrix1[x].size():
			if matrix1[x][y] != matrix2[x][y]:
				break
				return false
	return true

func updateMatrix(positionX: int, positionY: int, val: int) -> void:
	var playerMatrix = PlayerStatus.getPlayerLevelField()
	playerMatrix[positionX][positionY] = val
	PlayerStatus.setPlayerLevelField(playerMatrix)
	print("Player Matrix",PlayerStatus.getPlayerLevelField())
	print("Current Matrix", PlayerStatus.getCurrentLevelField())
