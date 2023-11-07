extends Control

@onready var plate = $ColorRect
@onready var timerTap = $TimeTap
@onready var button = $OnClick

var tween: Tween
var switch: bool 		= true
var timeWaitTap: float 	= 0.5
var noMore: bool		= false
var isDown: bool		= false
var colorStart: Color	= Color(0.075, 0.455, 0.894)
var colorEnd: Color		= Color(0, 0, 0)

func _ready():
	timerTap.wait_time = timeWaitTap
	timerTap.one_shot = true
	timerTap.autostart = false
	plate.color = colorStart
	tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", colorEnd, timeWaitTap)
	tween.stop()

func _process(delta):
	if noMore:
		return
	
	if isDown && timerTap.is_stopped():
		noMore = true
		button.disabled = true
	
	if !isDown && !timerTap.is_stopped():
		timerTap.stop()
		tween.stop()
		$ColorRect.color = colorStart

func _on_on_click_button_down():
	isDown = true
	timerTap.start()
	tween.play()

func _on_on_click_button_up():
	isDown = false
	noMore = false
