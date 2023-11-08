extends Node

func _ready():
	onReadyDefaultSettings()

# Сброс изначальных настроек
func onReadyDefaultSettings() -> void:
	self._currentPlayerStage = 0
	self._previosStage = _playerStage[_currentPlayerStage - 1]
	self._nextStage = _playerStage[_currentPlayerStage + 1]
	self._stage = _playerStage[_currentPlayerStage]
	self.currentSize = self._stage["LevelSize"]
	self._global_timer = 400
	self.LevelsCount = 1
	self._playerPoints = 0.00
	self._playerField.clear()
	self._currentField.clear()
	self._currentBuffStage.clear()
	self._currentDebuffStage.clear()
	self._isPath = false

# Матрица для текущего уровня
var _currentField: Array = []

# Баффы текущего уровня
var _buffStateCurrentLevel: Array = [] : set = setBuffStateCurrentLevel, get = getBuffStateCurrentLevel

# Примененный бафф
var _applyBuffId: Array = [] : set = setApplyBuffId, get = getApplyBuffId

# Массив бафов для текущей стадии
var _currentBuffStage: Array = [] : set = setCurrentBuffStage, get = getCurrentBuffStage

# Массив дебаффов для текущей стадии
var _currentDebuffStage: Array = [] : set = setCurrentDebuffStage, get = getCurrentDebuffStage

# Стадии игры
# ID - номер стадии
# PointsStage - количество общих очков для достижерия стадии
# TimePasle - Время на решение пазла
# MultiplePoints - Множитель очков НЕ ИСПОЛЬЗУЕТСЯ
# MultiPlePointsPerSecond - Количество отнимаемых очков каждую секунду
# PointsPerPasle - Количество очков за решеный пазл
# LevelSize - значения (2,3,4) размер поля. ЕСЛИ 0 ТО ПОЛЕ БЕРЕТ ПАРАМЕТР ИЗ БАФФОВ И ПРЕДЫДУЩЕЙ СТАДИИ
# PlatesBuffMin/PlatesBuffMax - Минимальное/Максимальное количество клеток на поле для целевого поля с баффом
# PlatesDebuffMin/PlatesDebuffMax - Минимальное/Максимальное количество клеток на поле для целевого поля с дебаффом
# Path - Если true, активен выбор путей, false - только одно целевое поле
# AvalibaleBuffsId - Массив с id баффов для текущей стадии
var _playerStage: Dictionary = {
	-3: {
		"PointsStage": -300.0,
		"TimePasle": 10.0,
		"MultiplePoints": -6.0,
		"MultiPlePointsPerSecond": 15.0,
		"PointsPerPasle": 300,
		"LevelSize": 2,
		"PlatesBuffMin": 1,
		"PlatesBuffMax": 2,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 2,
		"Path": false,
	},
	-2: {
		"PointsStage": -200.0,
		"TimePasle": 8.0,
		"MultiplePoints": -4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 2,
		"PlatesBuffMin": 1,
		"PlatesBuffMax": 3,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 3,
		"Path": false,
	},
	-1: {
		"PointsStage": -100.0,
		"TimePasle": 6.0,
		"MultiplePoints": -3.0,
		"MultiPlePointsPerSecond": 7.5,
		"PointsPerPasle": 150,
		"LevelSize": 3,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 3,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 3,
		"Path": false,
	},
	0: {
		"PointsStage": 0.0,
		"TimePasle": 5.0,
		"MultiplePoints": 1.0,
		"MultiPlePointsPerSecond": 2.5,
		"PointsPerPasle": 50,
		"LevelSize": 3,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 4,
		"PlatesDebuffMin": 1, 
		"PlatesDebuffMax": 3,
		"Path": false,
	},
	1: {
		"PointsStage": 100.0,
		"TimePasle": 4.75,
		"MultiplePoints": 1.0,
		"MultiPlePointsPerSecond": 2.5,
		"PointsPerPasle": 50,
		"LevelSize": 3,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 5,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 4,
		"Path": false,
	},
	2: {
		"PointsStage": 600.0,
		"TimePasle": 4.75,
		"MultiplePoints": 1.5,
		"MultiPlePointsPerSecond": 3.75,
		"PointsPerPasle": 75,
		"LevelSize": 3,
		"PlatesBuffMin": 3,
		"PlatesBuffMax": 5,
		"PlatesDebuffMin": 2,
		"PlatesDebuffMax": 4,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 8],
		"AvalibaleDebuffsId": [0, 1, 8],
	},
	3: {
		"PointsStage": 1550.0,
		"TimePasle": 3.75,
		"MultiplePoints": 2.0,
		"MultiPlePointsPerSecond": 5.0,
		"PointsPerPasle": 100,
		"LevelSize": 3,
		"PlatesBuffMin": 4,
		"PlatesBuffMax": 7,
		"PlatesDebuffMin": 3, 
		"PlatesDebuffMax": 5,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 8],
		"AvalibaleDebuffsId": [0, 1, 8],
	},
	4: {
		"PointsStage": 3800.0,
		"TimePasle": 3.5,
		"MultiplePoints": 4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 3,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 8, 9],
	},
	5: {
		"PointsStage": 8200.0,
		"TimePasle": 3.25,
		"MultiplePoints": 4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 4,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 8, 9],
	},
	6: {
		"PointsStage": 14600.0,
		"TimePasle": 2.85,
		"MultiplePoints": 8.5,
		"MultiPlePointsPerSecond": 21.25,
		"PointsPerPasle": 425,
		"LevelSize": 0,
		"PlatesBuffMin": 2, 
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 8, 9],
	},
	7: {
		"PointsStage": 28800.0,
		"TimePasle": 2.45,
		"MultiplePoints": 10.5,
		"MultiPlePointsPerSecond": 26.25,
		"PointsPerPasle": 525,
		"LevelSize": 0,
		"PlatesBuffMin": 2,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 1,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 7, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 7, 8, 9],
	},
	8: {
		"PointsStage": 43200.0,
		"TimePasle": 2.15,
		"MultiplePoints": 18.0,
		"MultiPlePointsPerSecond": 45.0,
		"PointsPerPasle": 900,
		"LevelSize": 0,
		"PlatesBuffMin": 3,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 2,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 7, 8, 9, 10],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 7, 8, 9, 10],
	},
	9: {
		"PointsStage": 64800.0,
		"TimePasle": 1.85,
		"MultiplePoints": 28.0,
		"MultiPlePointsPerSecond": 70.0,
		"PointsPerPasle": 1400,
		"LevelSize": 0,
		"PlatesBuffMin": 4,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 3,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		"AvalibaleDebuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	},
	10: {
		"PointsStage": 97200.0,
		"TimePasle": 1.55,
		"MultiplePoints": 30.0,
		"MultiPlePointsPerSecond": 75.0,
		"PointsPerPasle": 1500,
		"LevelSize": 0,
		"PlatesBuffMin": 4,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 3,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		"AvalibaleDebuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	},
	11: {
		"PointsStage": 125000.0,
		"TimePasle": 1.35,
		"MultiplePoints": 40.0,
		"MultiPlePointsPerSecond": 100.0,
		"PointsPerPasle": 2000,
		"LevelSize": 0,
		"PlatesBuffMin": 4,
		"PlatesBuffMax": 0,
		"PlatesDebuffMin": 3,
		"PlatesDebuffMax": 0,
		"Path": true,
		"AvalibaleBuffsId": [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		"AvalibaleDebuffsId": [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	},
}

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
var weightMatrixGenerationSize: float = 0.8

# Очки игрока
var _playerPoints: float = 0.00 : get = getPlayerPoints

# Стадия игрока
var _currentPlayerStage: int = 0 : set = setCurrentPlayerStage, get = getCurrentPlayerStage

var _isPath: bool = false : set = setPath, get = getPath

# Предыдущая стадия
var _previosStage: Dictionary = {}

# Следующая стадия
var _nextStage: Dictionary = {}

# Текущая стадия
var _stage: Dictionary = {}

# КОЛИЧЕСТВО УРОВНЕЙ ОЧЕНЬ ВАЖНАЯ ПЕРЕМЕННАЯ!!!!!!!!!!!!!!!! НЕ ТРОЖЬ ВСЕ СЛОМАЕТСЯ!!!!!!!!!
var LevelsCount = 1

# Матрица игрового поля
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField

# Статус готовности уровня
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel

# Статус сравнения матриц
var _matrixCompare: bool = false : set = setCompareMatrix, get = getCompareMatrix

# Общий таймер ( в секундах )
var _global_timer: float = 400 : set = setGlobalTimer, get = getGlobalTimer


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

func changeGlobalTimer(count: float) -> void:
	_global_timer += count

func minusGlobalTimer(count: float) -> void:
	_global_timer -= count
	
func setGlobalTimer(time: float) -> void:
	_global_timer = time
	
func getGlobalTimer() -> float:
	return _global_timer

func setCurrentStage(stageId: int) -> void:
	_stage = _playerStage[stageId]

func getCurrentStage() -> Dictionary:
	return _stage

func setCurrentPlayerStage(stageId: int) -> void:
	_currentPlayerStage = stageId

func getCurrentPlayerStage() -> int:
	return _currentPlayerStage

func setPlayerPointsPlus(points: float) -> void:
	_playerPoints += points

func setPlayerPointsMinus(points: float) -> void:
	_playerPoints -= points

func getPlayerPoints() -> float:
	return _playerPoints

func setPreviosStage():
	_previosStage = _playerStage[_currentPlayerStage - 1]

func getPreviosStage() -> Dictionary:
	return _previosStage

func setNextStage():
	_nextStage = _playerStage[_currentPlayerStage + 1]

func getNextStage() -> Dictionary:
	return _nextStage

func setPath(isPath: bool):
	_isPath = isPath

func getPath() -> bool:
	return _isPath

func getCurrentBuffStage() -> Array:
	return _currentBuffStage

func setCurrentBuffStage(buffs: Array) -> void:
	_currentBuffStage.clear()
	_currentBuffStage = buffs.duplicate(true)

func getCurrentDebuffStage() -> Array:
	return _currentDebuffStage

func setCurrentDebuffStage(buffs: Array) -> void:
	_currentDebuffStage.clear()
	_currentDebuffStage = buffs.duplicate(true)

func setBuffStateCurrentLevel(buffs: Array) -> void:
	_buffStateCurrentLevel.push_back(buffs)

func getBuffStateCurrentLevel() -> Array:
	return _buffStateCurrentLevel

func clearBuffStateCurrentLevel() -> void:
	_buffStateCurrentLevel.clear()

func setApplyBuffId(id) -> void:
	_applyBuffId.push_back(id)

func getApplyBuffId() -> Array:
	return _applyBuffId

func clearApplyBuffId() -> void:
	_applyBuffId.clear()
