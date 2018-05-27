extends "combat.gd"

var pos = 0

func enter(host):
	host.get_node('SpriteAnim').play('stagger')
	pos = host.position.x
	return 'stagger'

func update(direction,host,delta):
	knockback(direction,host,delta)

func exit(host):
	return

func knockback(direction,host,delta):
	direction = -direction
	if pos - host.position.x < 70:
		motion.x = SPEED * direction * 1.7
		moveGravity(host,delta)

func _on_SpriteAnim_animation_finished(anim_name):
	return 'previous'
