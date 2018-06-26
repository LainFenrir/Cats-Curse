extends "combat.gd"

var pos = 0
var distance = 0

func enter(host):
	host.get_node('SpriteAnim').play('stagger')
	pos = host.position.x
	return 'stagger'

func update(direction,host,delta):
	knockback(direction,host,delta)

func exit(host):
	return

func _on_SpriteAnim_animation_finished(anim_name):
	return 'previous'

######## Main Actions #############

func knockback(direction,host,delta):
	direction = -direction
	checkDistance(host)
	if distance < 70:
		motion.x = WALK_SPEED * direction * 1.7
		moveGravity(host,delta)

##### Utilities ##########

func checkDistance(host):
	distance = pos - host.position.x
	if distance < 0:
		distance = -distance