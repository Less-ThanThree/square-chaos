extends Control

#@onready var containerBox = $BoxContainer
@onready var plate = load("res://Scenes/Plates/Plate.tscn")
@onready var gridLevel = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	generateLevel(3, 6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateLevel(levelSize: int, maxPlate: int) -> void:
	var matrixLevel = GeneratorLevel.generateMatrixLevel(levelSize, maxPlate)
	print(matrixLevel)
	
	gridLevel.set_columns(levelSize)
	
	for x in matrixLevel.size():
		for y in matrixLevel[x].size():
			var plate_instance = plate.instantiate()
			plate_instance.set_name("plate")
			gridLevel.add_child(plate_instance)
