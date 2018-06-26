extends "../motion.gd"

func enter(host):
	host.get_node('SpriteAnim').play('walk')
	return 'walk'

func update(direction,host,delta):
	flipSprite(direction,host)
	walk(direction,host,delta)
	

func exit(host):
	host.get_node('SpriteAnim').stop()

##### Main Actions #############

func walk(direction,host,delta):
	horizontalMovement(direction,WALK_SPEED)
	moveGravity(host,delta)




