extends Node

const NORMAL= Vector2(0,-1) 
const GRAVITY = 20
const WALK_SPEED = 200
const RUN_SPEED = 300
const JUMP_HEIGHT = -400

var motion = Vector2()

########## Movement ###################
func move(host,delta):
	motion = host.move_and_slide(motion, NORMAL)

func moveGravity(host,delta):
	motion.y += GRAVITY
	motion = host.move_and_slide(motion, NORMAL)

func horizontalMovement(direction,speed):
		motion.x = speed * direction

func setHalfMotion(host,delta):
	motion *= .5
	moveGravity(host,delta)

func moveOnAir(direction,host):
	flipSprite(direction,host)
	if Input.is_action_pressed("run"):
		horizontalMovement(direction,RUN_SPEED)
	else:
		horizontalMovement(direction,WALK_SPEED)



######## Sprite ###################
func flipSprite(direction,host):
	if direction == -1:
		host.get_node("Sprite").flip_h = true
		host.get_node("RayCastWall").rotation_degrees = 90
		host.get_node("WallDetect/WallCollision").position.x = -6
	elif direction == 1:
		host.get_node("Sprite").flip_h = false
		host.get_node("RayCastWall").rotation_degrees = -90
		host.get_node("WallDetect/WallCollision").position.x = 6

func flipSpriteSlide(direction,host):
	if direction == 1:
		host.get_node("Sprite").flip_h = true
	elif direction == -1:
		host.get_node("Sprite").flip_h = false
