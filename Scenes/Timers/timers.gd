extends Node

const local_wait_time = 5 # in sec

# Эвент окончания общего таймера
signal global_timer_timeout

func _ready():
	self._refresh_global_tm()
	self._refresh_local_tm(local_wait_time)
	
	$TimerComponent/local_tm.start()
	$TimerComponent/tick_tm.start()
	
func _process(delta):
	pass
	
# Конвертирует время в секундах в строку формата "MM:SS"
func _convert_time(time: int) -> String:
	var minutes: int = int(time) / 60
	var seconds: int = int(time) % 60
	var str = "%02d:%02d"
	var formated_str = str % [minutes, seconds]
	
	return formated_str

# Эвент вызывается каждые 0.001sec
func _on_seconds_tm_timeout():	
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

func _refresh_local_tm(time: int):
	$TimerComponent/local_tm.wait_time = time
	$TimerComponent/Panel/local_progress.max_value = time

# Эвент изменения значения общего таймера
func change_global_timer(count: int):
	PlayerStatus.changeGlobalTimer(count)
	self._refresh_global_tm()
	
# Эвент вызывается когда локальный таймер заканчивается
func _on_local_tm_timeout():
	print("local expired")
	self._resume_global_tm()


# Эвент вызывается когда общий таймер заканчивается
func _on_global_tm_timeout():
	self.global_timer_timeout.emit()

# Эвент обновления локального таймера
func refresh_local_timer(time: int):
	$TimerComponent/global_tm.paused = true
	if($TimerComponent/local_tm.time_left > 0):
		self.change_global_timer($TimerComponent/local_tm.time_left)
	$TimerComponent/local_tm.wait_time = local_wait_time
	$TimerComponent/local_tm.start()
	


func _on_node_2d_compare_level():
	self.refresh_local_timer(local_wait_time)

