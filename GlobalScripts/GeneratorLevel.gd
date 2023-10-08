extends Node

@export var minGeneratePlate = 1
@export var maxGeneratePlate = 4

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
]

func generateMatrixLevel(size):
	var sumPlate = 0
	var matrixTemplate
	
	match size:
		2:
			matrixTemplate = matrixTemplateX2
		3:
			matrixTemplate = matrixTemplateX3
		4:
			matrixTemplate = matrixTemplateX4
	
	for x in matrixTemplate.size():
		var plateInRow = randi_range(0, matrixTemplate.size())
		for y in matrixTemplate[x].size():
			if randi_range(0, 1) == 1 && sumPlate <= maxGeneratePlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1
				
	for array in matrixTemplate.size():
		print(matrixTemplate[array])
