extends "../motion.gd"

var slide = true

func enter(host):
	host.get_node('SpriteAnim').play('slide')
	slide =true
	motion.y = 0
	return 'climb'

func update(direction,host,delta):
	motion.x = WALK_SPEED * direction
	if Input.is_action_pressed("ui_up") and host.get_node("WallDetect").get_overlapping_bodies():
		climb(direction,host,delta)
		slide = false
	if Input.is_action_pressed("ui_up") and not host.getRayWall():
		motion.y = -20
		motion.x = WALK_SPEED * direction
		move(host,delta)
	if Input.is_action_just_released("ui_up"):
		slide = true
	if Input.is_action_pressed("run"):
		slide = false
	if Input.is_action_just_released("run"):
		slide = true
	if slide:
		flipSpriteSlide(direction,host)
		slide(host,delta)





func exit(host):
	host.get_node('SpriteAnim').stop()
	return

#### Main Actions######################
func climb(direction,host,delta):
	motion.y = WALK_SPEED * -1
	motion *= .5 
	moveGravity(host,delta)

func slide(host,delta):
		setHalfMotion(host,delta)

func getUp(direction,host,delta):
	motion = Vector2((1000 * direction), -600)
	moveGravity(host,delta)
	host.changeState('jump')
### Utilities ############
