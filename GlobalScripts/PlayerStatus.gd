extends Node

# Матрица для текущего уровня
var _currentField: Array = []

# Размер матрицы 
# 2 - 2х2
# 3 - 3х3
# 4 - 4х4
var currentSize: int = 3

# Минимальное количество полей
var minPlate: int = 3

# Максимальное количество полей
var maxPlate: int = 6

# Вес генерации матрицы
var weightMatrixGenerationSize: float = 0.9

var LevelsCount = 2

# Матрица игрового поля
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField

# Статус готовности уровня
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel

# Статус сравнения матриц
var _matrixCompare: bool = false : set = setCompareMatrix, get = getCompareMatrix

# Общий таймер ( в секундах )
var _global_timer: int = 120 : set = setGlobalTimer, get = getGlobalTimer


func setCurrentLevelField() -> void:
	_currentField.clear()

func addField(field: Array):
	_currentField.append_array(field)

func getCurrentLevelField(field: int) -> Array:
	return _currentField[field]

func setPlayerLevelField(matrix: Array) -> void:
	_playerField = matrix

func getPlayerLevelField() -> Array:
	return _playerField

func setReadyLevel(isReady: bool) -> void:
	_readyLevel = isReady

func getReadyLevel() -> bool:
	return _readyLevel

func setCompareMatrix(isCompare: bool):
	_matrixCompare = isCompare
	return _matrixCompare

func getCompareMatrix() -> bool:
	return _matrixCompare

func setGlobalTimer(count: int) -> void:
	_global_timer += count
	
func getGlobalTimer() -> int:
	return _global_timer
