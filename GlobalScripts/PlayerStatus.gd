extends Node

var _currentField: Array = [] : set = setCurrentLevelField, get = getCurrentLevelField
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel
var matrixCompare = false

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
