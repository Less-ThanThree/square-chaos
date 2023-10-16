extends Node

# Матрица для текущего уровня
var _currentField: Array = []

var currentSize = 3

var LevelsCount = 2

# Матрица игрового поля
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField

# Статус готовности уровня
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel

# Статус сравнения матриц
var _matrixCompare: bool = false : set = setCompareMatrix, get = getCompareMatrix

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
