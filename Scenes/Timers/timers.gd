extends Node

var local_wait_time = 5 # in sec
@onready var timerFreeze = $TimerComponent/freeze_tm
@onready var panelTimer = $TimerComponent/Panel
@onready var panelFreeze = $TimerComponent/Freeze

# Эвент окончания общего таймера
signal global_timer_timeout

func _ready():
	var currentStage = PlayerStatus.getCurrentStage()
	
	local_wait_time = currentStage["TimePasle"]
	timerFreeze.wait_time = ProbabilityBank.TIMEFREEZE
	
	self._refresh_global_tm()
	self._refresh_local_tm(local_wait_time)
	
	$TimerComponent/local_tm.start()
	$TimerComponent/tick_tm.start()
	
func _process(delta):
	if PlayerStatus.getIsFreezeBuffActive():
		isFreeze()
	
# Конвертирует время в секундах в строку формата "MM:SS"
func _convert_time(time: int) -> String:
	var minutes: int = int(time) / 60
	var seconds: int = int(time) % 60
	var str = "%02d:%02d"
	var formated_str = str % [minutes, seconds]
	
	return formated_str

# Эвент вызывается каждые 0.001sec
func _on_seconds_tm_timeout():	
	_refresh_global_tm()
	if(!$TimerComponent/local_tm.is_stopped()):
		$TimerComponent/Panel/local_progress.value = local_wait_time - $TimerComponent/local_tm.time_left
	
	if(!$TimerComponent/global_tm.is_stopped() && !$TimerComponent/global_tm.paused):
		PlayerStatus.setGlobalTimer($TimerComponent/global_tm.time_left)
		$TimerComponent/Panel/global_tm_label.text = self._convert_time($TimerComponent/global_tm.time_left)

func _resume_global_tm():
	$TimerComponent/global_tm.paused = false
	$TimerComponent/global_tm.start()
	
# Обновляет состояние общего таймера в компоненте
func _refresh_global_tm():
	$TimerComponent/global_tm.wait_time = PlayerStatus.getGlobalTimer()	
	$TimerComponent/Panel/global_tm_label.text = self._convert_time(PlayerStatus.getGlobalTimer())

func _refresh_local_tm(time: float):
	$TimerComponent/local_tm.wait_time = time
	$TimerComponent/Panel/local_progress.max_value = time

# Эвент изменения значения общего таймера
func change_global_timer(count: float):
	self._refresh_global_tm()
	
# Эвент вызывается когда локальный таймер заканчивается
func _on_local_tm_timeout():
	self._refresh_global_tm()
	self._resume_global_tm()

# Эвент вызывается когда общий таймер заканчивается
func _on_global_tm_timeout():
	self.global_timer_timeout.emit()

# Эвент обновления локального таймера
func refresh_local_timer(time: float):
	$TimerComponent/global_tm.paused = true
	if($TimerComponent/local_tm.time_left > 0):
		self.change_global_timer($TimerComponent/local_tm.time_left)
	$TimerComponent/local_tm.wait_time = local_wait_time
	$TimerComponent/local_tm.start()
	
func _on_node_2d_compare_level():
	var currentStage = PlayerStatus.getCurrentStage()
	local_wait_time = currentStage["TimePasle"]
	
	self.refresh_local_timer(local_wait_time)

func isFreeze():
	PlayerStatus.setIsFreezeBuffActive(false)
	
	$TimerComponent/local_tm.set_paused(true)
	$TimerComponent/global_tm.set_paused(true)
	
	panelTimer.visible = false
	panelFreeze.visible = true
	
	timerFreeze.start()

func _on_freeze_tm_timeout():
	$TimerComponent/local_tm.set_paused(false)
	
	panelFreeze.visible = false
	panelTimer.visible = true
