extends "../motion.gd"

func enter(host):
	host.get_node('SpriteAnim').play('run')
	return 'run'

func update(direction,host,delta):
	flipSprite(direction,host)
	run(direction,host,delta)

func exit(host):
	host.get_node('SpriteAnim').stop()


###### Main Actions #####
func run(direction,host,delta):
	horizontalMovement(direction,RUN_SPEED)
	moveGravity(host,delta)
