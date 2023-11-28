extends Control

@onready var plate = load("res://Scenes/Plates/PlateDefault.tscn")
@onready var gridLevel = $GridContainer
@onready var colorBuff = $ContainerBuff/ColorBuff
@onready var buffLabel = $ContainerBuff/ColorBuff/LabelBuff
#@onready var fadeBuffRect = $FadeBuffRect
#@onready var timerFadingWait = $timerFadingWait
#@onready var timerFadingGeneral = $timerFadingGeneral

var currentStage: Dictionary
var buffState: Array
#var fadeColorStart: Color = Color(0.361, 0.361, 0.361, 0)
#var fadeColorEnd: Color = Color(0.361, 0.361, 0.361, 1)
#var tween: Tween

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
	currentStage = PlayerStatus.getCurrentStage()
	
	if (PlayerStatus.getPath()):
		colorBuff.visible = true
		
		buffState = ProbabilityBank.rollBuff(currentStage["AvalibaleBuffsId"], currentStage["AvalibaleDebuffsId"])
		setBuff(buffState[0], buffState[1])
		PlayerStatus.setBuffStateCurrentLevel([buffState[0], buffState[1]])
		
		if (buffState[1] == ProbabilityBank.StateBuff.BUFF):
			setPlateSize(currentStage["PlatesBuffMin"], currentStage["PlatesBuffMax"])
		elif (buffState[1] == ProbabilityBank.StateBuff.DEBUFF):
			setPlateSize(currentStage["PlatesDebuffMin"], currentStage["PlatesDebuffMax"])
	else:
		colorBuff.visible = false
	
	generateLevel(PlayerStatus.currentSize, PlayerStatus.minPlate, PlayerStatus.maxPlate)
	
#	fadeBuffRect.color = fadeColorStart
#
#	tween = get_tree().create_tween()
#	tween.tween_property(fadeBuffRect, "color", fadeColorEnd, ProbabilityBank.StateFading["FadeTime"])
#	tween.tween_property(fadeBuffRect, "color", fadeColorStart, ProbabilityBank.StateFading["FadeTime"])
#	tween.tween_property(fadeBuffRect, "color", fadeColorStart, ProbabilityBank.StateFading["FadeTime"])
#	tween.stop()
#
#	timerFadingWait.wait_time = ProbabilityBank.StateFading["VisibleTime"]
#	timerFadingGeneral.wait_time = ProbabilityBank.StateFading["GeneralTime"]

func _process(delta):
	if PlayerStatus.getCompareMatrix():
		freeLevel()
		
		currentStage = PlayerStatus.getCurrentStage()
		
		if (PlayerStatus.getPath()):
			colorBuff.visible = true
			
			buffState = ProbabilityBank.rollBuff(currentStage["AvalibaleBuffsId"], currentStage["AvalibaleDebuffsId"])

			setBuff(buffState[0], buffState[1])
			PlayerStatus.setBuffStateCurrentLevel([buffState[0], buffState[1]])
			
			if (buffState[1] == ProbabilityBank.StateBuff.BUFF):
				setPlateSize(currentStage["PlatesBuffMin"], currentStage["PlatesBuffMax"])
			elif (buffState[1] == ProbabilityBank.StateBuff.DEBUFF):
				setPlateSize(currentStage["PlatesDebuffMin"], currentStage["PlatesDebuffMax"])
		else:
			colorBuff.visible = false
		
		if currentStage["LevelSize"] != 0:
			PlayerStatus.currentSize = currentStage["LevelSize"]
		print("LevelSize: ", PlayerStatus.currentSize)
		generateLevel(PlayerStatus.currentSize, PlayerStatus.minPlate, PlayerStatus.maxPlate)
	
#	if PlayerStatus.getIsFadingBuffActive():
#		setFadeDebuff()

# Генерация матрицы для уровня levelSize: размер матрицы, 
# maxPlate: максимальное количество полей
# minPlate: минимальное количество полей
func generateLevel(levelSize: int, minPlate: int, maxPlate: int):
	
	if minPlate > maxPlate:
		printerr("MinPlate не может быть больше MaxPlate ИДИОТ")
		return null
	if maxPlate >= (levelSize * levelSize ):
		printerr("MaxPlate не может быть больше или равен размеру матрицы ИДИОТ")
		print("LevelSize: ", levelSize)
		return null
	if levelSize <= 1 || levelSize >= 5: 
		printerr("Размер матрицы за переделами значений 2 - 4 ИДИОТ")
		return null
	if maxPlate <= 0 || minPlate <= 0:
		printerr("MaxPlate или MinPlate не может быть отрицательным числом или нулем ИДИОТ")
		return null
	
	var matrixTemplate: Array
	
	matrixTemplate = matchMatrix(levelSize)
	matrixTemplate = generateMatrix(matchMatrix(levelSize), minPlate, maxPlate, levelSize)
	
	GeneratorLevel.levelsGenerate += 1
	
	if PlayerStatus.LevelsCount == 2 && GeneratorLevel.levelsGenerate == 2:
		var currentBuffs = PlayerStatus.getBuffStateCurrentLevel()
		var buffLevel = currentBuffs[1]
		print("BUUUUFS" ,buffLevel)
		if currentBuffs[0][1] == buffLevel[1]:
			while currentBuffs[0][0] == buffLevel[0]:
				buffLevel = ProbabilityBank.rollBuff(currentStage["AvalibaleBuffsId"], currentStage["AvalibaleDebuffsId"])
			setBuff(buffLevel[0], buffLevel[1])
			PlayerStatus.setBuffStateCurrentLevel([buffLevel[0], buffLevel[1]])
		while PlayerStatus.setCompareMatrix(GeneratorLevel.compareMatrix(PlayerStatus.getCurrentLevelField(0), matrixTemplate)):
				matrixTemplate = generateMatrix(matchMatrix(levelSize), minPlate, maxPlate, levelSize)
				print("Regenerate matrix")
	
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

func matchMatrix(sizes: int) -> Array:
	var matrixTemplate: Array
	
	match(sizes):
		2:
			matrixTemplate = matrixTemplateX2.duplicate(true)
		3:
			matrixTemplate = matrixTemplateX3.duplicate(true)
		4:
			matrixTemplate = matrixTemplateX4.duplicate(true)
	return matrixTemplate

func generateMatrix(matrixTemplate: Array, minPlate: int, maxPlate: int, levelSize: int) -> Array:
	var sumPlate = 0

	for x in matrixTemplate.size():
		for y in matrixTemplate[x].size():
			if randf_range(0, 1) >= PlayerStatus.weightMatrixGenerationSize && sumPlate < maxPlate:
				matrixTemplate[x][y] = 1
				sumPlate += 1

	while sumPlate < minPlate:
		sumPlate = 0
		matrixTemplate.clear()
		matrixTemplate = matchMatrix(levelSize)
		for x in matrixTemplate.size():
				for y in matrixTemplate[x].size():
					if randf_range(0, 1) >= PlayerStatus.weightMatrixGenerationSize && sumPlate < maxPlate:
						matrixTemplate[x][y] = 1
						sumPlate += 1
	return matrixTemplate

# Очищаем уровень
func freeLevel() -> void:
	for node in gridLevel.get_children():
		gridLevel.remove_child(node)
		node.queue_free()
	compareLevel.emit()

# Устанавливаем бафф/дебафф на уровень
func setBuff(idBuff: int, type: int) -> void:
	if type == ProbabilityBank.StateBuff.BUFF:
		colorBuff.set_color(Color(0, 0.804, 0.18))
		buffLabel.text = ProbabilityBank.buffs[idBuff]["Name"]
	elif type == ProbabilityBank.StateBuff.DEBUFF:
		colorBuff.set_color(Color(0.743, 0, 0.127))
		buffLabel.text = ProbabilityBank.debuffs[idBuff]["Name"]

# Устанавливаем максимальное/минимальное количество полей на уровень
func setPlateSize(minPlate: int, maxPlate: int) -> void:
	print("MinPlate: ", PlayerStatus.minPlate)
	print("MaxPlate: ", PlayerStatus.maxPlate)
	if (maxPlate != 0):
		PlayerStatus.maxPlate = maxPlate
	if (minPlate != 0):
		PlayerStatus.minPlate = minPlate
	
	if (maxPlate > (PlayerStatus.currentSize * PlayerStatus.currentSize)):
		PlayerStatus.maxPlate = (PlayerStatus.currentSize * PlayerStatus.currentSize) - 1

#func setFadeDebuff():
#	PlayerStatus.setIsFadingBuffActive(false)
#	timerFadingGeneral.start()
#	timerFadingWait.start()

#func _on_timer_fading_wait_timeout():
#	tween.stop()
#	tween.tween_property(fadeBuffRect, "color", fadeColorEnd, ProbabilityBank.StateFading["FadeTime"])
#	tween.tween_property(fadeBuffRect, "color", fadeColorStart, ProbabilityBank.StateFading["FadeTime"])
#	tween.play()
#	timerFadingWait.start()
#
#func _on_timer_fading_general_timeout():
#	tween.stop()
#	timerFadingWait.stop()
#	tween.tween_property(fadeBuffRect, "color", fadeColorStart, ProbabilityBank.StateFading["FadeTime"])
#	tween.play()
