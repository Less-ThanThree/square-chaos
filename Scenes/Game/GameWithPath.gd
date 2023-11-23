extends Node

@onready var rectFadingField1 = $fadeField1
@onready var rectFadingField2 = $fadeField2
@onready var timerGlobal = $TimerGlobalTime
@onready var timerWaitField1 = $TimerWaitField1
@onready var timerWaitField2 = $TimerWaitField2
@onready var timerInvisibleField1 = $TimerInvisibleTimeFiled1
@onready var timerInvisibleField2 = $TimerInvisibleTimeField2

var colorStart = Color(0.353, 0.353, 0.353, 0)
var colorEnd = Color(0.353, 0.353, 0.353, 1)
var tween: Tween

func _ready():
	rectFadingField1.color = colorStart
	rectFadingField2.color = colorStart
	timerGlobal.wait_time = ProbabilityBank.StateFading["GeneralTime"]
	timerWaitField1.wait_time = ProbabilityBank.StateFading["VisibleTime"]
	timerWaitField2.wait_time = ProbabilityBank.StateFading["VisibleTime"]
	timerInvisibleField1.wait_time = ProbabilityBank.StateFading["InvisibleTime"]
	timerInvisibleField2.wait_time = ProbabilityBank.StateFading["InvisibleTime"]

func _process(delta):
	if PlayerStatus.getIsFadingBuffActive():
		startFade()

func startFade():
	PlayerStatus.setIsFadingBuffActive(false)
	
	timerGlobal.start()
	timerWaitField1.start()
	
func _on_timer_global_time_timeout():
	timerWaitField1.stop()
	timerWaitField2.stop()
	timerInvisibleField1.stop()
	timerInvisibleField2.stop()
	
	tween = get_tree().create_tween()
	tween.parallel().tween_property(rectFadingField1, "color", colorStart, ProbabilityBank.StateFading["FadeOutTime"])
	tween.parallel().tween_property(rectFadingField2, "color", colorStart, ProbabilityBank.StateFading["FadeOutTime"])
	tween.play()

func _on_timer_wait_field_1_timeout():
	tween = get_tree().create_tween()
	tween.parallel().tween_property(rectFadingField1, "color", colorEnd, ProbabilityBank.StateFading["FadeInTime"])
	tween.play()
	
	timerInvisibleField1.start()

func _on_timer_invisible_time_filed_1_timeout():
	tween = get_tree().create_tween()
	tween.parallel().tween_property(rectFadingField1, "color", colorStart, ProbabilityBank.StateFading["FadeOutTime"])
	tween.play()

	timerWaitField2.start()

func _on_timer_wait_field_2_timeout():
	tween = get_tree().create_tween()
	tween.parallel().tween_property(rectFadingField2, "color", colorEnd, ProbabilityBank.StateFading["FadeInTime"])
	tween.play()

	timerInvisibleField2.start()

func _on_timer_invisible_time_field_2_timeout():
	tween = get_tree().create_tween()
	tween.parallel().tween_property(rectFadingField2, "color", colorStart, ProbabilityBank.StateFading["FadeOutTime"])
	tween.play()
#
	timerWaitField1.start()
