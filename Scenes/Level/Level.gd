extends Control

#@onready var containerBox = $BoxContainer
@onready var plate = load("res://Scenes/Plates/PlateDefault.tscn")
@onready var gridLevel = $GridContainer
signal readyLevel
signal compareLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	generateLevel(3, 6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerStatus.getCompareMatrix():
		freeLevel()
		generateLevel(3, 6)

# Генерация матрицы для уровня levelSize: размер матрицы, maxPlate: максимальное количество полей
func generateLevel(levelSize: int, maxPlate: int) -> void:
	var matrixLevel = GeneratorLevel.generateMatrixLevel(levelSize, maxPlate)
	
	gridLevel.set_columns(levelSize)
	
	for x in matrixLevel.size():
		for y in matrixLevel[x].size():
			var plate_instance = plate.instantiate()
			plate_instance.set_name("plate")
			gridLevel.add_child(plate_instance)
			if matrixLevel[x][y] == 1:
				plate_instance.get_node("ColorRect").set_color(Color(0, 0, 0))
	readyLevel.emit()

# Очищаем уровень
func freeLevel():
	for node in gridLevel.get_children():
		gridLevel.remove_child(node)
		node.queue_free()
	compareLevel.emit()
