extends Node

const NORMAL= Vector2(0,-1) 
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -400

var motion = Vector2()

func move(host,delta):
	motion = host.move_and_slide(motion, NORMAL)

func moveGravity(host,delta):
	motion.y += GRAVITY
	motion = host.move_and_slide(motion, NORMAL)

func flipSprite(direction,host):
	if direction == -1:
		host.get_node("Sprite").flip_h = true
		host.get_node("RayCastWall").rotation_degrees = 90
	elif direction == 1:
		host.get_node("Sprite").flip_h = false
		host.get_node("RayCastWall").rotation_degrees = -90

func horizontalMovement(direction):
		motion.x = SPEED * direction

func invertSprite(direction,host):
	direction = -direction
	if direction == -1:
		host.get_node("Sprite").flip_h = true
	elif direction == 1:
		host.get_node("Sprite").flip_h = false