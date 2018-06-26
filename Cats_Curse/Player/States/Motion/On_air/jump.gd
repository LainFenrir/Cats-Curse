extends "../motion.gd"


var isControlJumping = false
var slide = false
var disableInput = false

func enter(host):
	motion.x = 0
	host.get_node('SpriteAnim').play('jump')
	return 'jump'

func update(direction,host,delta):
	if host.is_on_floor():
		isControlJumping = false
		groundJump(direction,host,delta)
	if host.getOnWall() and Input.is_action_just_pressed("ui_accept"):
		wallJump(direction,host,delta)
	elif not host.is_on_floor():
		fall(host,delta)
	if Input.is_action_just_released("ui_accept"):
		controlJump(host,delta)

func exit(host):
	return

############# Main Actions ##########################

func groundJump(direction,host,delta):
	flipSprite(direction,host)
	setFullMotion(host,delta)

func wallJump(direction,host,delta):
	direction = -  direction
	motion.x = 90 * direction
	disableInput = true
	$DisableInputTimer.start()
	moveJumping(direction,host)
	setFullMotion(host,delta)

func moveJumping(direction,host):
	if not disableInput:
		moveOnAir(direction,host)

func controlJump(host,delta):
	if not isControlJumping:
		setHalfMotion(host,delta)
		isControlJumping = true

############ Utilities #################

func setFullMotion(host,delta):
	motion.y = JUMP_HEIGHT
	moveGravity(host,delta)

func fall(host,delta):
	moveGravity(host,delta)

func _on_DisableInputTimer_timeout():
	disableInput = false
