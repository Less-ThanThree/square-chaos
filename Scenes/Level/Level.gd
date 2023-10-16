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

# Called when the node enters the scene tree for the first time.
func _ready():
	generateLevel(PlayerStatus.currentSize, 6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerStatus.getCompareMatrix():
		freeLevel()
		generateLevel(PlayerStatus.currentSize, 6)

# Генерация матрицы для уровня levelSize: размер матрицы, maxPlate: максимальное количество полей
func generateLevel(levelSize: int, maxPlate: int) -> void:
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
			if randi_range(0, 1) == 1 && sumPlate <= maxPlate:
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
