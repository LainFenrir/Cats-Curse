extends "../motion.gd"

var cameraNode
var isLookingUp = false

func enter(host):
	host.get_node('SpriteAnim').play('idle')
	return 'idle'

func update(host,delta):
	stop(host,delta)
	

func exit(host):
	host.get_node('SpriteAnim').stop()
	if isLookingUp:
		resetLookUp()
	return

############### Main Actions ###############
func stop(host,delta):
	motion.x = 0
	moveGravity(host,delta)

func lookUp(host):
	isLookingUp = true
	cameraNode = host.get_node("Camera2D/CameraAnim")
	cameraNode.play("look_up")

func resetLookUp():
	if isLookingUp:
		cameraNode.play_backwards("look_up")
	isLookingUp = false