extends Node

var isLookingDown = false
var cameraNode

func enter(host):
	host.get_node('SpriteAnim').play('crouch')
	cameraNode = host.get_node("Camera2D/CameraAnim")
	startTimer()
	return 'crouch'

func update(direction,host,delta):
	if Input.is_action_just_pressed("attack"):
		startTimer()
		resetLookDown()


func exit(host):
	host.get_node('SpriteAnim').stop()
	$LookDownTimer.stop()
	resetLookDown()
	return

###### Main Actions ######

func lookDown():
	isLookingDown = true
	cameraNode.play("look_down")

func resetLookDown():
	if isLookingDown:
		cameraNode.play_backwards("look_down")
	isLookingDown = false

###### Utilities ########

func startTimer():
	$LookDownTimer.start()

func _on_LookDownTimer_timeout():
	lookDown()
