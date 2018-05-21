extends Node

var isLookingDown = false
var cameraNode

func enter(host):
	#host.get_node('SpriteAnim').play('crouch')
	cameraNode = host.get_node("Camera2D/CameraAnim")
	startTimer(host)
	return 'crouch'

func update(host):
	if Input.is_action_just_pressed("attack"):
		startTimer(host)
		resetLookDown()


func exit(host):
	host.get_node('LookDownTimer').stop()
	resetLookDown()
	return

func lookDown():
	isLookingDown = true
	cameraNode.play("look_down")

func resetLookDown():
	if isLookingDown:
		cameraNode.play_backwards("look_down")
	isLookingDown = false

func startTimer(host):
	host.get_node('LookDownTimer').start()

func _on_LookDownTimer_timeout():
	lookDown()
