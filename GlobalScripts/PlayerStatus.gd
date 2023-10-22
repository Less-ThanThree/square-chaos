extends Node

# Матрица для текущего уровня
var _currentField: Array = []

# Стадии игры
var _playerStage: Dictionary = {
	-3: {
		"TimePasle": 10.0,
		"MultiplePoints": -6.0,
		"MultiPlePointsPerSecond": 15.0,
		"PointsPerPasle": 300,
		"LevelSize": 2,
		"PlatesBuff": range(1, 2),
		"PlatesDebuff": range(1, 2),
		"Path": false,
	},
	-2: {
		"TimePasle": 8.0,
		"MultiplePoints": -4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 2,
		"PlatesBuff": range(1, 3),
		"PlatesDebuff": range(1, 3),
		"Path": false,
	},
	-1: {
		"TimePasle": 6.0,
		"MultiplePoints": -3.0,
		"MultiPlePointsPerSecond": 7.5,
		"PointsPerPasle": 150,
		"LevelSize": 3,
		"PlatesBuff": range(2, 3),
		"PlatesDebuff": range(1, 3),
		"Path": false,
	},
	0: {
		"TimePasle": 5.0,
		"MultiplePoints": 1.0,
		"MultiPlePointsPerSecond": 2.5,
		"PointsPerPasle": 50,
		"LevelSize": 3,
		"PlatesBuff": range(2, 4),
		"PlatesDebuff": range(1, 3),
		"Path": false,
	},
	1: {
		"TimePasle": 4.75,
		"MultiplePoints": 1.0,
		"MultiPlePointsPerSecond": 2.5,
		"PointsPerPasle": 50,
		"LevelSize": 3,
		"PlatesBuff": range(2, 5),
		"PlatesDebuff": range(1, 4),
		"Path": false,
	},
	2: {
		"TimePasle": 4.75,
		"MultiplePoints": 1.5,
		"MultiPlePointsPerSecond": 3.75,
		"PointsPerPasle": 75,
		"LevelSize": 3,
		"PlatesBuff": range(3, 5),
		"PlatesDebuff": range(2, 4),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 8],
		"AvalibaleDebuffsId": [0, 1, 8],
	},
	3: {
		"TimePasle": 3.75,
		"MultiplePoints": 2.0,
		"MultiPlePointsPerSecond": 5.0,
		"PointsPerPasle": 100,
		"LevelSize": 3,
		"PlatesBuff": range(4, 7),
		"PlatesDebuff": range(3, 5),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 8],
		"AvalibaleDebuffsId": [0, 1, 8],
	},
	4: {
		"TimePasle": 3.5,
		"MultiplePoints": 4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 3,
		"PlatesBuff": range(2, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(1, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 8, 9],
	},
	5: {
		"TimePasle": 3.25,
		"MultiplePoints": 4.0,
		"MultiPlePointsPerSecond": 10.0,
		"PointsPerPasle": 200,
		"LevelSize": 4,
		"PlatesBuff": range(2, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(1, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 8, 9],
	},
	6: {
		"TimePasle": 2.85,
		"MultiplePoints": 8.5,
		"MultiPlePointsPerSecond": 21.25,
		"PointsPerPasle": 425,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(2, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(1, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 8, 9],
	},
	7: {
		"TimePasle": 2.45,
		"MultiplePoints": 10.5,
		"MultiPlePointsPerSecond": 26.25,
		"PointsPerPasle": 525,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(2, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(1, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 7, 8, 9],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 7, 8, 9],
	},
	8: {
		"TimePasle": 2.15,
		"MultiplePoints": 18.0,
		"MultiPlePointsPerSecond": 45.0,
		"PointsPerPasle": 900,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(3, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(2, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 4, 5, 6, 7, 8, 9, 10],
		"AvalibaleDebuffsId": [0, 1, 4, 5, 6, 7, 8, 9, 10],
	},
	9: {
		"TimePasle": 1.85,
		"MultiplePoints": 28.0,
		"MultiPlePointsPerSecond": 70.0,
		"PointsPerPasle": 1400,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(4, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(3, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		"AvalibaleDebuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	},
	10: {
		"TimePasle": 1.55,
		"MultiplePoints": 30.0,
		"MultiPlePointsPerSecond": 75.0,
		"PointsPerPasle": 1500,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(4, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(3, self.getPlayerLevelField().size()),
		"Path": true,
		"AvalibaleBuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
		"AvalibaleDebuffsId": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
	},
	11: {
		"TimePasle": 1.35,
		"MultiplePoints": 40.0,
		"MultiPlePointsPerSecond": 100.0,
		"PointsPerPasle": 2000,
		"LevelSize": self.currentSize,
		"PlatesBuff": range(4, self.getPlayerLevelField().size()),
		"PlatesDebuff": range(3, self.getPlayerLevelField().size()),
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
var weightMatrixGenerationSize: float = 0.9

var LevelsCount = 2

# Матрица игрового поля
var _playerField: Array = [] : set = setPlayerLevelField, get = getPlayerLevelField

# Статус готовности уровня
var _readyLevel: bool = false : set = setReadyLevel, get = getReadyLevel

# Статус сравнения матриц
var _matrixCompare: bool = false : set = setCompareMatrix, get = getCompareMatrix

# Общий таймер ( в секундах )
var _global_timer: float = 120 : set = setGlobalTimer, get = getGlobalTimer


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
	
func setGlobalTimer(time: float) -> void:
	_global_timer = time
	
func getGlobalTimer() -> float:
	return _global_timer
