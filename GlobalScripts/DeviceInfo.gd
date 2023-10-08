extends Node

var RENDERDEVICE = RenderingServer.get_rendering_device()

func _ready():
	#Device Name
	print(RENDERDEVICE.get_device_name())
	print("%1.2fMB" % (RENDERDEVICE.get_memory_usage(RenderingDevice.MEMORY_TOTAL) / 1048576.0))
