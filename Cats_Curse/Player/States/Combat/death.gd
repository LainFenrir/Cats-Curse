extends "combat.gd"

onready var respawnPoint = get_node("/root/teste/RespawnPoint")
var start = true
func enter(host):
	start =  true
	host.get_node('SpriteAnim').play('stagger')
	motion = Vector2(0,-400)
	return 'death'

func update(host,delta):
	lockCamera(host)
	die(host,delta)

func exit(host):
	host.get_node('SpriteAnim').stop()
	return

####### Main Actions #######
func die(host,delta):
	host.translate(motion * delta)
	motion.y += GRAVITY * delta *40
	if start:
		start = false
		$DeathTimer.start()

func respawn(host,direction):
	host.get_node("Camera2D").make_current()
	host.set_position(respawnPoint.position)


###### Utilities #########

func lockCamera(host):
	host.get_node("Camera2D").clear_current()

