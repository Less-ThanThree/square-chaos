extends Node

const local_wait_time = 5 # in sec
const global_wait_time = 60 # in sec

# Called when the node enters the scene tree for the first time.
func _ready():
	$local_tm.wait_time = local_wait_time
	$local_tm.one_shot = true
	$local_tm.start()
	
	$global_tm.wait_time = global_wait_time
		
	$local_progress.max_value = local_wait_time
	$Panel/global_tm_label.text = "1:00"
	
	$seconds_tm.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Эвент вызывается когда локальный таймер заканчивается
func _on_local_tm_timeout():
	self.resume_global_tm()
	pass # Replace with function body.
	

# Эвент вызывается каждые 0.001sec
func _on_seconds_tm_timeout():	
	if(!$local_tm.is_stopped()):
		$local_progress.value = local_wait_time - $local_tm.time_left
	
	if(!$global_tm.is_stopped()):
		var minutes: int = int($global_tm.time_left) / 60
		var seconds: int = int($global_tm.time_left) % 60
		$Panel/global_tm_label.text = "{minutes}:{seconds}".format({"minutes": minutes, "seconds": seconds})
	
		
	pass # Replace with function body.

func resume_global_tm():
	$global_tm.start()
