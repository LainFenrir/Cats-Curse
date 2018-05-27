extends "combat.gd"


func enter(host):
	host.get_node('SpriteAnim').play('fall')
	motion = Vector2(0,-400)
	return 'death'

func update(host,delta):
	lockCamera(host)
	die(host,delta)

func exit(host):
	host.get_node('SpriteAnim').stop()
	return

func die(host,delta):
	host.translate(motion * delta)
	motion.y += GRAVITY * delta *40

func lockCamera(host):
	host.get_node("Camera2D").clear_current()