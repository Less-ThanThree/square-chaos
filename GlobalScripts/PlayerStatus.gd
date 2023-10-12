extends Node

# Матрица для текущего уровня
var _currentField: Array = [] : set = setCurrentLevelField, get = getCurrentLevelField

# Матрица игрового поля
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField

# Статус готовности уровня
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel

# Статус сравнения матриц
var _matrixCompare: bool = false : set = setCompareMatrix, get = getCompareMatrix

func setCurrentLevelField(matrix: Array) -> void:
	_currentField = matrix

func getCurrentLevelField() -> Array:
	return _currentField

func setPlayerLevelField(matrix: Array) -> void:
	_playerField = matrix

func getPlayerLevelField() -> Array:
	return _playerField

func setReadyLevel(isReady: bool) -> void:
	_readyLevel = isReady

func getReadyLevel() -> bool:
	return _readyLevel

func setCompareMatrix(isCompare: bool) -> void:
	_matrixCompare = isCompare

func getCompareMatrix() -> bool:
	return _matrixCompare
