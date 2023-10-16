extends Control

@onready var plate = load("res://Scenes/Plates/PlateDefault.tscn")
@onready var gridLevel = $GridContainer
signal readyLevel
signal compareLevel

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

func _ready():
	generateLevel(PlayerStatus.currentSize, PlayerStatus.minPlate, PlayerStatus.maxPlate)

func _process(delta):
	if PlayerStatus.getCompareMatrix():
		freeLevel()
		generateLevel(PlayerStatus.currentSize, PlayerStatus.minPlate, PlayerStatus.maxPlate)

# Генерация матрицы для уровня levelSize: размер матрицы, 
# maxPlate: максимальное количество полей
# minPlate: минимальное количество полей
func generateLevel(levelSize: int, minPlate: int, maxPlate: int):
	
	if minPlate > maxPlate:
		printerr("MinPlate не может быть больше MaxPlate ИДИОТ")
		return null
	if maxPlate >= (levelSize * levelSize ):
		printerr("MaxPlate не может быть больше или равен размеру матрицы ИДИОТ")
		return null
	if levelSize <= 1 || levelSize >= 5: 
		printerr("Размер матрицы за переделами значений 2 - 4 ИДИОТ")
		return null
	if maxPlate <= 0 || minPlate <= 0:
		printerr("MaxPlate или MinPlate не может быть отрицательным числом или нулем ИДИОТ")
		return null
	
	var sumPlate = 0
	var matrixTemplate: Array
	
	print("Generate Level")
	
	match(levelSize):
		2:
			matrixTemplate = matrixTemplateX2.duplicate(true)
		3:
			matrixTemplate = matrixTemplateX3.duplicate(true)
		4:
			matrixTemplate = matrixTemplateX4.duplicate(true)
	
	for x in matrixTemplate.size():
		for y in matrixTemplate[x].size():
			if randi_range(0, 1) == 1 && sumPlate < maxPlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1
	
	while sumPlate < minPlate:
		sumPlate = 0
		matrixTemplate.clear()
		for x in matrixTemplate.size():
			for y in matrixTemplate[x].size():
				if randi_range(0, 1) == 1 && sumPlate < maxPlate:
					matrixTemplate[x][y] = 1
					sumPlate += 1
	
	PlayerStatus.addField([matrixTemplate])
	
	gridLevel.set_columns(levelSize)
	
	for x in matrixTemplate.size():
		for y in matrixTemplate[x].size():
			var plate_instance = plate.instantiate()
			plate_instance.set_name("plate")
			gridLevel.add_child(plate_instance)
			if matrixTemplate[x][y] == 1:
				plate_instance.get_node("ColorRect").set_color(Color(0, 0, 0))
	readyLevel.emit()

# Очищаем уровень
func freeLevel():
	for node in gridLevel.get_children():
		gridLevel.remove_child(node)
		node.queue_free()
	compareLevel.emit()
