extends Node

# Шанс выпадения баффа
var chanceBuff = 0.5

# Шанс выпадения дебаффа
var chanceDebuff = 0.5

# Состояние баффа/дебаффа
enum StateBuff {
	BUFF = 0,
	DEBUFF = 1,
}

enum StateEffect {
	POINTS = 5,
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
		"time": 5.0,
	},
	8: {
		"time": 5.0,
	},
	9: {
		"time": 5.0,
	},
	10: {
		"time": 5.0,
	},
	11: {
		"time": 5.0,
	},
	12: {
		"time": 5.0,
	}
}

# Словарь баффа
# W - Вес
# M - Множитель уменьшения веса
# С - Счетчик, изначальное значение 0 НЕ ТРОГАТЬ
# Max - Счетчик максимума
var buffs: Dictionary = {
	0: {
		"W": 50.0,
		"M": 5.0,
		"C": 0,
		"Max": 5,
		"Name": "Плюс время",
		"Description": "Прибавляет (+) N кол-во времени × (Множитель стадии ВРЕМЕНИ) к общему таймеру.",
	},
	1: {
		"W": 50.0,
		"M": 5.0,
		"C": 0,
		"Max": 6,
		"Name": "Плюс очки",
		"Description": "Прибавляет (+) кол-во очков × (Множитель очков) к счётчику очков."
	},
	2: {
		"W": 50.0,
		"M": 5.0,
		"C": 0,
		"Max": 4,
		"Name": "Сужение поля",
		"Description": "Меняет размер игрового и целевого поля, (начиная с следующего пазла), на меньшее. Игровое поле НЕ может быть меньше (2x2) "
	},
	3: {
		"W": 15.0,
		"M": 5.0,
		"C": 0,
		"Max": 5,
		"Name": "Отключение ошибок",
		"Description": "отключает функцию 'механика ошибок'. При нажатии на те клетки игрового поля, что не учавствует ни в одном из патернов целевого поля, игрока штрафуют на N кол-во очков × (Множитель очков) и аннулируют активированные ячейки на игровом поле."
	},
	4: {
		"W": 10.0,
		"M": 5.0,
		"C": 0,
		"Max": 9,
		"Name": "Меньше клеток",
		"Description": "Уменьшает (-) количество клеток на Целевом поле на N кол-во, но НЕ может быть < Кол-во клетокдля поле бафов / дебафов или > (Размер игрового поля - 1). Однако если у игрока минимально допустимое количество клеток для данной стадии, то исключаем выпадение бафа – 'уменьшение'."
	},
	5: {
		"W": 30.0,
		"M": 5.0,
		"C": 0,
		"Max": 10,
		"Name": "Меньше ледяных клеток",
		"Description": "Убавляет (-)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	6: {
		"W": 40.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Меньше защищенных клеток",
		"Description": "Убавляет (-)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	7: {
		"W": 5.0,
		"M": 5.0,
		"C": 0,
		"Max": 5,
		"Name": "Больше золотых клеток",
		"Description": "Прибавляет (+)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	8: {
		"W": 5.0,
		"M": 5.0,
		"C": 0,
		"Max": 6,
		"Name": "Более контрастная палитра",
		"Description": "Увлеичивает (➕) контрастность клеток паттерна Целевого поля."
	},
	9: {
		"W": 5.0,
		"M": 5.0,
		"C": 0,
		"Max": 8,
		"Name": "Увеличить шанс выпадения баффа",
		"Description": "Прибавляет (➕) N% к выпадению двух полей бафов или дебафов. На старте игры, вероятности выпадения баффа и дебаффа на Целевых полях #1 и #2 установлены как 50% / 50%. Однако если выпадет этот баф, то шанс исходный шанс можно увеличить и соотвественно убавить для бафа или дебафа."
	},
	10: {
		"W": 5.0,
		"M": 5.0,
		"C": 0,
		"Max": 4,
		"Name": "Временная защита",
		"Description": "Позволяет игроку N раз избежать получения дебафа при выборе пути с дебафом.",
	},
	11: {
		"W": 5.0,
		"M": 5.0,
		"C": 0,
		"Max": 3,
		"Name": "Фризер",
		"Description": "Убирает ограничение по времени, позволяя игроку решать пазлы в течение N времени без спешки.",
	}
}

# Словарь дебаффа
var debuffs: Dictionary = {
	0: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Минус время",
		"Description": "Убавляет (-) N кол-во времени × (Множитель стадии ВРЕМЕНИ) к общему таймеру.",
	},
	1: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Минус время",
		"Description": "Убавляет (-) кол-во очков × (Множитель очков) к счётчику очков."
	},
	2: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Расширение поля",
		"Description": "Меняет размер игрового и целевого поля, (начиная с следующего пазла), на большее. Игровое поле НЕ может быть больше (4x4) "
	},
	3: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Включение ошибок",
		"Description": "Включает функцию 'механика ошибок'. При нажатии на те клетки игрового поля, что не учавствует ни в одном из патернов целевого поля, игрока штрафуют на N кол-во очков × (Множитель очков) и аннулируют активированные ячейки на игровом поле."
	},
	4: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Больше клеток",
		"Description": "Если у игрока количество клеток = (Размер игрового поля - 1), то исключаем выпадение бафа – 'Прибавление'."
	},
	5: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Больше ледяных клеток",
		"Description": "Прибавляет (+)  текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	6: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Больше защищенных клеток",
		"Description": "Прибавляет (+) текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	7: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Меньше золотых клеток",
		"Description": "Уменьшает (-) текущую вероятность появления на Целевом поле разновидности клеток с [название эффекта]. Если вероятность одного из эффектов = 0, то исключаем выпадение – 'меньше [название эффекта]'. Если вероятность одного из эффектов > 40%, то исключаем выпадение – 'больше [название эффекта]'. И при этом сумма всех эффектов бафов и дебафов НЕ может быть > 80%",
	},
	8: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Менее контрастная палитра",
		"Description": "Уменьшает (-) контрастность клеток паттерна Целевого поля."
	},
	9: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Увеличить шанс выпадения дебаффа",
		"Description": "Прибавляет (+) N% к выпадению двух полей бафов или дебафов. На старте игры, вероятности выпадения баффа и дебаффа на Целевых полях #1 и #2 установлены как 50% / 50%. Однако если выпадет этот баф, то шанс исходный шанс можно увеличить и соотвественно убавить для бафа или дебафа."
	},
	10: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
		"Name": "Медленное угасание",
		"Description": "В течении [Общее Время] на Целевые поля применяется этот эффект. После появления пазла, пазл в течении [Время Видимости Пазла] виден игроку, в течении [Время Угасания Пазла] угасает, [Время Невидимости Пазла] не виден игроку и [Время Возвращения Пазла] снова возвращается и виден игроку и после [Время Ожидания] эффект повторяется."
	},
	11: {
		"W": 20.0,
		"M": 5.0,
		"C": 0,
		"Max": 2,
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
		print(PlayerStatus.getCurrentBuffStage())
		print(PlayerStatus.getCurrentBuffStage().size())
		currentBuffId = chooseBuff(StateBuff.BUFF, PlayerStatus.getCurrentBuffStage().size(), PlayerStatus.getCurrentBuffStage())
		if currentBuffId == -1:
			print("Error")
		else:
			print("Current Buff: %s" % self.buffs[currentBuffId]["Name"])
			print("Weight: %10.2f" % self.buffs[currentBuffId]["W"])
			print("Multiple: %8.2f" % self.buffs[currentBuffId]["M"])
			print("Counter: %6d" % self.buffs[currentBuffId]["C"])
			print("Max: %10d" % self.buffs[currentBuffId]["Max"])
			return [currentBuffId, StateBuff.BUFF]
	else:
		PlayerStatus.setCurrentDebuffStage(createBuffArray(StateBuff.DEBUFF, stageArrayDebuff))
		print(PlayerStatus.getCurrentDebuffStage())
		currentBuffId = chooseBuff(StateBuff.DEBUFF, PlayerStatus.getCurrentDebuffStage().size(), PlayerStatus.getCurrentDebuffStage())
		if currentBuffId == -1:
			print("Error")
		else:
			print("Current Debuff: %s" % self.debuffs[currentBuffId]["Name"])
			print("Weight: %10.2f" % self.debuffs[currentBuffId]["W"])
			print("Multiple: %8.2f" % self.debuffs[currentBuffId]["M"])
			print("Counter: %6d" % self.debuffs[currentBuffId]["C"])
			print("Max: %10d" % self.debuffs[currentBuffId]["Max"])
			return [currentBuffId, StateBuff.DEBUFF]
	return -1

# Выбор бафа/дебафа на основе вероятностей
func chooseBuff(type: int, size: int, currentBuffArray: Array) -> int:
	var probabilitis: Array
	var randVal = randf() * 100
	var sumProb = 0.0
	
	for i in range(size):
		probabilitis.push_front(probability(i, currentBuffArray))
	
	for i in range(size):
		sumProb += probabilitis[i]
		if randVal <= sumProb:
			updateAfterDrop(i, currentBuffArray)
			return i
		updateWithoutDrop(i, currentBuffArray)
		
	return -1

# Вычисление вероятности для бафа/дебафа i
func probability(idBuff: int, currentArrayBuff: Array) -> float:
	var sumWeight: float
	
	for buff in currentArrayBuff:
		sumWeight += buff["W"]
	
	return currentArrayBuff[idBuff]["W"] / sumWeight * 100

# Обновление счётчика, если баф/дебаф не выпал
func updateWithoutDrop(idBuff: int, currentArrayBuff: Array) -> void:

	currentArrayBuff[idBuff]["C"] += 1
	if currentArrayBuff[idBuff]["C"] == currentArrayBuff[idBuff]["Max"]:
		currentArrayBuff[idBuff]["W"] += currentArrayBuff[idBuff]["M"]
		currentArrayBuff[idBuff]["C"] = 0

# Обновление весов и счётчиков после выпадения бафа/дебафа i
func updateAfterDrop(idBuff: int, currentArrayBuff: Array) -> void:
	
	currentArrayBuff[idBuff]["W"] -= currentArrayBuff[idBuff]["M"]
	for i in currentArrayBuff.size():
		if i != idBuff:
			currentArrayBuff[i]["W"] += currentArrayBuff[idBuff]["M"] / (currentArrayBuff.size() - 1)
	
	currentArrayBuff[idBuff]["C"]

# Инициализируем массив баффоф/дебафоф для текущей стадии
func createBuffArray(type: int, buffIdArray: Array) -> Array:
	var currentBuff: Array
	
	if type == StateBuff.BUFF:
		for id in buffIdArray:
			currentBuff.append(buffs[id])
	
	if type == StateBuff.DEBUFF:
		for id in buffIdArray:
			currentBuff.append(debuffs[id])
	
	return currentBuff

func effectBuff(buffId: int, type: int) -> void:
	var stage: Dictionary = PlayerStatus.getCurrentStage()

	match buffId:
		0:
			if StateBuff.BUFF == type:
				PlayerStatus.changeGlobalTimer(effectTimeBuff[PlayerStatus.getCurrentPlayerStage()]["time"])
			elif StateBuff.DEBUFF == type:
				PlayerStatus.minusGlobalTimer(effectTimeBuff[PlayerStatus.getCurrentPlayerStage()]["time"])
		1:
			if StateBuff.BUFF == type:
				PlayerStatus.setPlayerPointsPlus(StateEffect.POINTS * stage["MultiplePoints"])
			elif StateBuff.DEBUFF == type:
				PlayerStatus.setPlayerPointsMinus(StateEffect.POINTS * stage["MultiplePoints"])
