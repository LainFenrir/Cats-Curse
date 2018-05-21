extends "../motion.gd"


var isControlJumping = false
var slide = false


func enter(host):
	motion.x = 0
	host.get_node('SpriteAnim').play('jump')
	return 'jump'

func update(direction,host,delta):
	if host.is_on_floor():
		isControlJumping = false
		groundJump(direction,host,delta)
	elif host.getOnWall() and not host.is_on_floor():
		wallSlide(direction,host,delta)
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

func wallSlide(direction,host,delta):
	if Input.is_action_pressed("ui_right") and host.getOnWall():
		setHalfMotion(host,delta)
		slide  = true
		isControlJumping = false
	elif Input.is_action_pressed("ui_left") and host.getOnWall():
		setHalfMotion(host,delta)
		slide = true
		isControlJumping = false
	else:
		fall(host,delta)
		slide = false
	if Input.is_action_just_pressed("ui_accept") and slide:
		wallJump(direction,host,delta)

func controlJump(host,delta):
	if not isControlJumping:
		setHalfMotion(host,delta)
		isControlJumping = true

func moveJumping(direction,host):
	flipSprite(direction,host)
	horizontalMovement(direction)


############ Utilities #################

func setHalfMotion(host,delta):
	motion *= .5
	moveGravity(host,delta)

func setFullMotion(host,delta):
	motion.y = JUMP_HEIGHT
	moveGravity(host,delta)

func fall(host,delta):
	moveGravity(host,delta)

func wallJump(direction,host,delta):
	direction = -direction
#	motion.x = 250 * direction
	moveJumping(direction,host)
	setFullMotion(host,delta)