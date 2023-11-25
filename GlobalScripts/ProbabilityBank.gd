extends Node

# Шанс выпадения баффа
var chanceBuff = 0.5

# Шанс выпадения дебаффа
var chanceDebuff = 0.5

# Шанс выпадения замороженной клетки
var chanceFreezePlate = 0.05

# Шанс выпадения защищенной клетки
var chanceDefensePlate = 0.025

# Шанс выпадения золотой клетки
var chanceGoldPlate = 0.05

# Константа для баффа/дебаффа шанса выпадения
var PROCENTDBF = 0.05

# Константа на выпадение различных клеток
var PROCENTPLATE = 0.05

# Время действия баффа фризер
var TIMEFREEZE: float = 5

# Количество ходов баффа временная защита
var TEMPDEFENS = 5

# Массив исключенных баффов
var exceptionBuffIdArray: Array = []

# Массив исключенных дебаффов
var exceptionDebuffIdArray: Array = []

# Состояние для дебаффа медленное угасание
var StateFading: Dictionary = {
	"GeneralTime": 20.0,
	"VisibleTime":4.0,
	"InvisibleTime": 2.0,
	"FadeInTime": 1.0,
	"FadeOutTime": 1.0,
}

# Состояние баффа/дебаффа
enum StateBuff {
	BUFF = 0,
	DEBUFF = 1,
}

# POINTS - Константа добавления очков к множетелю стадии
# ERRORPOINTS - Константа убавления очков к множетелю стадии
enum StateEffect {
	POINTS = 150,
	ERRORPOINTS = 25,
}

# Словарь бафф/дебаффов эффекта времени
var effectTimeBuff: Dictionary = {
	2: {
		"time": 5.0,
	},
	3: {
		"time": 5.0,
	},
	4: {
		"time": 5.0,
	},
	5: {
		"time": 5.0,
	},
	6: {
		"time": 5.0,
	},
	7: {
		"time": 10.0,
	},
	8: {
		"time": 10.0,
	},
	9: {
		"time": 15.0,
	},
	10: {
		"time": 15.0,
	},
	11: {
		"time": 20.0,
	},
	12: {
		"time": 20.0,
	}
}

# Словарь бафф эффекта клеток
var effectPlateAdd: Dictionary = {
	4: {
		"plate": 1,
	},
	5: {
		"plate": 1,
	},
	6: {
		"plate": 1,
	},
	7: {
		"plate": 1,
	},
	8: {
		"plate": 1,
	},
	9: {
		"plate": 1,
	},
	10: {
		"plate": 2,
	},
	11: {
		"plate": 2,
	},
	12: {
		"plate": 2,
	}
}

# Словарь дебаффа эффекта клеток
var effectPlateMinus: Dictionary = {
	4: {
		"plate": 1,
	},
	5: {
		"plate": 1,
	},
	6: {
		"plate": 1,
	},
	7: {
		"plate": 1,
	},
	8: {
		"plate": 1,
	},
	9: {
		"plate": 1,
	},
	10: {
		"plate": 2,
	},
	11: {
		"plate": 2,
	},
	12: {
		"plate": 2,
	}
}

# Словарь баффа
# ID - Идентификатор баффа/дебаффа
# W - Вес
# M - Множитель уменьшения веса
# С - Счетчик, изначальное значение 0 НЕ ТРОГАТЬ
# Max - Счетчик максимума
var buffs: Dictionary = {
	0: {
		"ID": 0,
		"W": 85.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Плюс время",
		"Description": "Прибавляет (+) N кол-во времени × (Множитель стадии ВРЕМЕНИ) к общему таймеру.",
	},
	1: {
		"ID": 1,
		"W": 85.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Плюс очки",
		"Description": "Прибавляет (+) кол-во очков × (Множитель очков) к счётчику очков."
	},
	2: {
		"ID": 2,
		"W": 35.0,
		"M": 35.0,
		"C": 0,
		"Max": 5,
		"Name": "Сужение поля",
		"Description": "Меняет размер игрового и целевого поля, (начиная с следующего пазла), на меньшее. Игровое поле НЕ может быть меньше (2x2) "
	},
	3: {
		"ID": 3,
		"W": 20.0,
		"M": 20.0,
		"C": 0,
		"Max": 10,
		"Name": "Отключение ошибок",
		"Description": "отключает функцию 'механика ошибок'. При нажатии на те клетки игрового поля, что не учавствует ни в одном из патернов целевого поля, игрока штрафуют на N кол-во очков × (Множитель очков) и аннулируют активированные ячейки на игровом поле."
	},
	4: {
		"ID": 4,
		"W": 60.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Меньше клеток",
		"Description": "Уменьшает (-) количество клеток на Целевом поле на N кол-во, но НЕ может быть < Кол-во клетокдля поле бафов / дебафов или > (Размер игрового поля - 1). Однако если у игрока минимально допустимое количество клеток для данной стадии, то исключаем выпадение бафа – 'уменьшение'."
	},
	5: {
		"ID": 5,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Меньше ледяных клеток",
		"Description": "Убавляет (-)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	6: {
		"ID": 6,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Меньше защищенных клеток",
		"Description": "Убавляет (-)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	7: {
		"ID": 7,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Больше золотых клеток",
		"Description": "Прибавляет (+)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	8: {
		"ID": 8,
		"W": 45.0,
		"M": 10.0,
		"C": 0,
		"Max": 5,
		"Name": "Более контрастная палитра",
		"Description": "Увлеичивает (➕) контрастность клеток паттерна Целевого поля."
	},
	9: {
		"ID": 9,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 5,
		"Name": "Увеличить шанс выпадения баффа",
		"Description": "Прибавляет (➕) N% к выпадению двух полей бафов или дебафов. На старте игры, вероятности выпадения баффа и дебаффа на Целевых полях #1 и #2 установлены как 50% / 50%. Однако если выпадет этот баф, то шанс исходный шанс можно увеличить и соотвественно убавить для бафа или дебафа."
	},
	10: {
		"ID": 10,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 10,
		"Name": "Временная защита",
		"Description": "Позволяет игроку N раз избежать получения дебафа при выборе пути с дебафом.",
	},
	11: {
		"ID": 11,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 15,
		"Name": "Фризер",
		"Description": "Убирает ограничение по времени, позволяя игроку решать пазлы в течение N времени без спешки.",
	}
}

# Словарь дебаффа
var debuffs: Dictionary = {
	0: {
		"ID": 0,
		"W": 85.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Минус время",
		"Description": "Убавляет (-) N кол-во времени × (Множитель стадии ВРЕМЕНИ) к общему таймеру.",
	},
	1: {
		"ID": 1,
		"W": 85.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Минус очки",
		"Description": "Убавляет (-) кол-во очков × (Множитель очков) к счётчику очков."
	},
	2: {
		"ID": 2,
		"W": 35.0,
		"M": 35.0,
		"C": 0,
		"Max": 5,
		"Name": "Расширение поля",
		"Description": "Меняет размер игрового и целевого поля, (начиная с следующего пазла), на большее. Игровое поле НЕ может быть больше (4x4) "
	},
	3: {
		"ID": 3,
		"W": 20.0,
		"M": 20.0,
		"C": 0,
		"Max": 10,
		"Name": "Включение ошибок",
		"Description": "Включает функцию 'механика ошибок'. При нажатии на те клетки игрового поля, что не учавствует ни в одном из патернов целевого поля, игрока штрафуют на N кол-во очков × (Множитель очков) и аннулируют активированные ячейки на игровом поле."
	},
	4: {
		"ID": 4,
		"W": 60.0,
		"M": 30.0,
		"C": 0,
		"Max": 3,
		"Name": "Больше клеток",
		"Description": "Если у игрока количество клеток = (Размер игрового поля - 1), то исключаем выпадение бафа – 'Прибавление'."
	},
	5: {
		"ID": 5,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Больше ледяных клеток",
		"Description": "Прибавляет (+)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	6: {
		"ID": 6,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Больше защищенных клеток",
		"Description": "Прибавляет (+) текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	7: {
		"ID": 7,
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Меньше золотых клеток",
		"Description": "Уменьшает (-) текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	8: {
		"ID": 8,
		"W": 45.0,
		"M": 10.0,
		"C": 0,
		"Max": 5,
		"Name": "Менее контрастная палитра",
		"Description": "Уменьшает (-) контрастность клеток паттерна Целевого поля."
	},
	9: {
		"ID": 9,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 5,
		"Name": "Увеличить шанс выпадения дебаффа",
		"Description": "Прибавляет (+) N% к выпадению двух полей бафов или дебафов. На старте игры, вероятности выпадения баффа и дебаффа на Целевых полях #1 и #2 установлены как 50% / 50%. Однако если выпадет этот баф, то шанс исходный шанс можно увеличить и соотвественно убавить для бафа или дебафа."
	},
	10: {
		"ID": 10,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 10,
		"Name": "Медленное угасание",
		"Description": "В течении [Общее Время] на Целевые поля применяется этот эффект. После появления пазла, пазл в течении [Время Видимости Пазла] виден игроку, в течении [Время Угасания Пазла] угасает, [Время Невидимости Пазла] не виден игроку и [Время Возвращения Пазла] снова возвращается и виден игроку и после [Время Ожидания] эффект повторяется."
	},
	11: {
		"ID": 11,
		"W": 30.0,
		"M": 15.0,
		"C": 0,
		"Max": 15,
		"Name": "Туман",
		"Description": " В течении N времени на Целвые поля применяется этот эффект. Создает абстрактные помехи и аномалии на экране, мешая игроку видеть паттерн целевых полей.",
	},
}

func rollBuff(stageArrayBuff: Array, stageArrayDebuff: Array):
	var procentBuff: float = randf_range(0, self.chanceBuff)
	var procentDebuff: float = randf_range(0, self.chanceDebuff)
	var currentBuffId
	var buffCurrentStage: Dictionary
	
	if procentBuff > procentDebuff:
		PlayerStatus.setCurrentBuffStage(createBuffArray(StateBuff.BUFF, stageArrayBuff))
#		var test = PlayerStatus.getCurrentBuffStage()
#		print(PlayerStatus.getCurrentBuffStage())
		currentBuffId = chooseBuff(StateBuff.BUFF, PlayerStatus.getCurrentBuffStage().size(), PlayerStatus.getCurrentBuffStage())
		if currentBuffId == -1:
			print("Error")
		else:
#			print("Current Buff: %s" % self.buffs[currentBuffId]["Name"])
#			print("Weight: %10.2f" % self.buffs[currentBuffId]["W"])
#			print("Multiple: %8.2f" % self.buffs[currentBuffId]["M"])
#			print("Counter: %6d" % self.buffs[currentBuffId]["C"])
#			print("Max: %10d" % self.buffs[currentBuffId]["Max"])
			return [currentBuffId, StateBuff.BUFF]
	else:
		PlayerStatus.setCurrentDebuffStage(createBuffArray(StateBuff.DEBUFF, stageArrayDebuff))
#		var test = PlayerStatus.getCurrentDebuffStage()
#		print(PlayerStatus.getCurrentDebuffStage())
		currentBuffId = chooseBuff(StateBuff.DEBUFF, PlayerStatus.getCurrentDebuffStage().size(), PlayerStatus.getCurrentDebuffStage())
		if currentBuffId == -1:
			print("Error")
		else:
#			print("Current Debuff: %s" % self.debuffs[currentBuffId]["Name"])
#			print("Weight: %10.2f" % self.debuffs[currentBuffId]["W"])
#			print("Multiple: %8.2f" % self.debuffs[currentBuffId]["M"])
#			print("Counter: %6d" % self.debuffs[currentBuffId]["C"])
#			print("Max: %10d" % self.debuffs[currentBuffId]["Max"])
			return [currentBuffId, StateBuff.DEBUFF]
	return -1

# Выбор бафа/дебафа на основе вероятностей
func chooseBuff(type: int, size: int, currentBuffArray: Array) -> int:
	var probabilitis: Array
	var randVal: float
	var sumProb = 0.0
	var idChooseBuff
	
	for i in range(size):
		probabilitis.push_front(probability(i, currentBuffArray))
	
	randVal = randf_range(0, probabilitis.max())
#	print("Вероятность выпадения баффа: %8.2f" % randVal)
	
	var counter: int = 0
	for buff in currentBuffArray:
		counter += 1
		if randVal <= probabilitis[counter]:
			if type == StateBuff.BUFF:
				updateAfterDrop(buff["ID"], buffs)
			elif type == StateBuff.DEBUFF:
				updateAfterDrop(buff["ID"], debuffs)
			idChooseBuff = buff["ID"]
			break
	
	for buff in currentBuffArray:
		if StateBuff.BUFF:
			if idChooseBuff != buff["ID"]:
				updateWithoutDrop(buff["ID"], buffs)
		if StateBuff.DEBUFF:
			if idChooseBuff != buff["ID"]:
				updateWithoutDrop(buff["ID"], debuffs)
	
	return idChooseBuff

# Вычисление вероятности для бафа/дебафа i
func probability(idBuff: int, currentArrayBuff: Array) -> float:
	var sumWeight: float
	
	for buff in currentArrayBuff:
		sumWeight += buff["W"]
	
	return currentArrayBuff[idBuff]["W"] / sumWeight * 100

# Обновление счётчика, если баф/дебаф не выпал
func updateWithoutDrop(idBuff: int, currentArrayBuff: Dictionary) -> void:

	currentArrayBuff[idBuff]["C"] += 1
	if currentArrayBuff[idBuff]["C"] == currentArrayBuff[idBuff]["Max"]:
		currentArrayBuff[idBuff]["W"] += currentArrayBuff[idBuff]["M"]
		currentArrayBuff[idBuff]["C"] = 0

# Обновление весов и счётчиков после выпадения бафа/дебафа i
func updateAfterDrop(idBuff: int, currentArrayBuff: Dictionary) -> void:
	var sum: float = currentArrayBuff[idBuff]["W"] - currentArrayBuff[idBuff]["M"]
	
#	if sum < 0.0:
#		currentArrayBuff[idBuff]["W"] = 0.00001
#	else:
#		currentArrayBuff[idBuff]["W"] -= currentArrayBuff[idBuff]["M"]
	for i in currentArrayBuff.size():
		if i != idBuff:
			currentArrayBuff[i]["W"] += currentArrayBuff[idBuff]["M"] / (currentArrayBuff.size() - 1)

# Инициализируем массив баффоф/дебафоф для текущей стадии
func createBuffArray(type: int, buffIdArray: Array) -> Array:
	var currentBuff: Array
	
	if type == StateBuff.BUFF:
		buffIdArray = updateBuffException(buffIdArray, type)
		for id in buffIdArray:
			currentBuff.append(buffs[id])
	
	if type == StateBuff.DEBUFF:
		buffIdArray = updateBuffException(buffIdArray, type)
		for id in buffIdArray:
			currentBuff.append(debuffs[id])
	
	return currentBuff

func updateBuffException(buffArray: Array, type: int) -> Array:
	if buffArray.has(2):
		if PlayerStatus.currentSize == 2 && (type == StateBuff.BUFF):
			buffArray.erase(2)
		elif PlayerStatus.currentSize == 4 && (type == StateBuff.DEBUFF):
			buffArray.erase(2)
	
	if buffArray.has(3):
		if !PlayerStatus.getIsErrorPlateBuffActive() && type == StateBuff.BUFF:
			buffArray.erase(3)
		elif PlayerStatus.getIsErrorPlateBuffActive() && type == StateBuff.DEBUFF:
			buffArray.erase(3)
	
	if buffArray.has(4):
		if PlayerStatus.minPlate == 1 && (type == StateBuff.BUFF):
			buffArray.erase(4)
		
		if PlayerStatus.maxPlate == ((PlayerStatus.currentSize * PlayerStatus.currentSize) - 1) && StateBuff.DEBUFF:
			buffArray.erase(4)
	
	if buffArray.has(5):
		if chanceFreezePlate <= 0 && (type == StateBuff.BUFF):
			buffArray.erase(5)
		elif chanceFreezePlate >= 0.4 && (type == StateBuff.DEBUFF):
			buffArray.erase(5)
	
	if buffArray.has(6):
		if chanceDefensePlate <= 0 && (type == StateBuff.BUFF):
			buffArray.erase(6)
		elif chanceDefensePlate >= 0.4 && (type == StateBuff.DEBUFF):
			buffArray.erase(6)
	
	if buffArray.has(7):
		if chanceGoldPlate <= 0 && (type == StateBuff.BUFF):
			buffArray.erase(7)
		elif chanceGoldPlate >= 0.4 && (type == StateBuff.DEBUFF):
			buffArray.erase(7)
	
	if buffArray.has(9):
		if chanceBuff >= 0.7 && (type == StateBuff.BUFF):
			buffArray.erase(9)
		elif chanceDebuff >= 0.7 && (type == StateBuff.DEBUFF):
			buffArray.erase(9)

	return buffArray

func effectBuff(buffId: int, type: int) -> void:
	var stage: Dictionary = PlayerStatus.getCurrentStage()

	match buffId:
		0:
			if StateBuff.BUFF == type:
				print("EFFECT PLUS TIME")
				PlayerStatus.changeGlobalTimer(effectTimeBuff[PlayerStatus.getCurrentPlayerStage()]["time"])
			elif StateBuff.DEBUFF == type:
				print("EFFECT MINUS TIME")
				PlayerStatus.minusGlobalTimer(effectTimeBuff[PlayerStatus.getCurrentPlayerStage()]["time"])
		1:
			if StateBuff.BUFF == type:
				print("EFFECT ADD POINTS")
				PlayerStatus.setPlayerPointsPlus(StateEffect.POINTS * stage["MultiplePoints"])
			elif StateBuff.DEBUFF == type:
				print("EFFECT MINUS POINTS")
				PlayerStatus.setPlayerPointsMinus(StateEffect.POINTS * stage["MultiplePoints"])
		2:
			if StateBuff.BUFF == type:
				print("EFFECT SMALL FIELD SIZE")
				if PlayerStatus.currentSize > 2:
					PlayerStatus.currentSize -= 1
					PlayerStatus.minPlate = 1
					PlayerStatus.maxPlate = (PlayerStatus.currentSize * PlayerStatus.currentSize) - 1
				
			elif StateBuff.DEBUFF == type:
				print("EFFECT BIGGER FIELD SIZE")
				if PlayerStatus.currentSize > 2 && PlayerStatus.currentSize < 4:
					PlayerStatus.currentSize += 1
					PlayerStatus.minPlate = 1
					PlayerStatus.maxPlate = (PlayerStatus.currentSize * PlayerStatus.currentSize) - 1
		3:
			if StateBuff.BUFF == type:
				print("Disable error Plate")
				PlayerStatus.setIsErrorPlateBuffActive(false)
			elif StateBuff.DEBUFF == type:
				print("Active error Plate")
				PlayerStatus.setIsErrorPlateBuffActive(true)
		4:
			if StateBuff.BUFF == type:
				print("EFFECT SMALL PLATE")
				if PlayerStatus.maxPlate > PlayerStatus.minPlate:
					PlayerStatus.maxPlate -= effectPlateMinus[PlayerStatus.getCurrentPlayerStage()]["plate"]
					if PlayerStatus.minPlate > 1:
						PlayerStatus.minPlate -= 1
			elif StateBuff.DEBUFF == type:
				print("EFFECT MORE PLATE")
				if PlayerStatus.maxPlate < ((PlayerStatus.currentSize * PlayerStatus.currentSize) - 1):
					PlayerStatus.maxPlate += effectPlateAdd[PlayerStatus.getCurrentPlayerStage()]["plate"]
					PlayerStatus.minPlate += 1
					print("check")
		5:
			if StateBuff.BUFF == type:
				print("EFFECT LESS CHANCE FREEZE PLATE")
				chanceFreezePlate -= PROCENTPLATE
			elif StateBuff.DEBUFF == type:
				print("EFFECT MORE CHANCE FREEZE PLATE ")
				chanceFreezePlate += PROCENTPLATE
		6:
			if StateBuff.BUFF == type:
				print("EFFECT LESS CHANCE DEFENSE PLATE")
				chanceDefensePlate -= PROCENTPLATE
			elif StateBuff.DEBUFF == type:
				print("EFFECT MORE CHANCE DEFENSE PLATE")
				chanceDefensePlate += PROCENTPLATE
		7:
			if StateBuff.BUFF == type:
				print("EFFECT MORE CHANCE GOLD PLATE")
				chanceGoldPlate += PROCENTPLATE
			elif StateBuff.DEBUFF == type:
				print("EFFECT LESS CHANCE GOLD PLATE")
				chanceGoldPlate += PROCENTPLATE
		8:
			pass
		9:
			if StateBuff.BUFF == type:
				print("MORE CHANCE BUFF")
				chanceBuff += PROCENTDBF
				chanceDebuff -= PROCENTDBF
			elif StateBuff.DEBUFF == type:
				print("MORE CHANCE DEBUFF")
				chanceDebuff += PROCENTDBF
				chanceBuff -= PROCENTDBF
		10:
			if StateBuff.BUFF == type:
				print("DEFENSE BUFF")
				PlayerStatus.setIsDefenseBuffActive(true)
				PlayerStatus.setPlayerDefenseCount(TEMPDEFENS)
			elif StateBuff.DEBUFF == type:
				print("FADING DEBUFF")
				PlayerStatus.setIsFadingBuffActive(true)
		11:
			if StateBuff.BUFF == type:
				print("TIME FREEZE")
				PlayerStatus.setIsFreezeBuffActive(true)
				
