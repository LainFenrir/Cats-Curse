extends Area2D


func _on_Obstacle_body_entered(body):
	body.changeState('stagger')
