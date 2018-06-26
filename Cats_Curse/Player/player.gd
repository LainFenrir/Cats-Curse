extends Node

onready var statesMap = {'idle' : $States/Idle,
 'walk' : $States/Walk,
 'jump' : $States/Jump,
 'crouch' : $States/Crouch,
 'stagger' : $States/Stagger,
 'death' : $States/Death,
 'attack' : $States/Attack,
 'climb' : $States/Climb,
 'run' : $States/Run }

var stateStack = []
var currentState = null
var stateName 
var onWall setget ,getOnWall
var direction
var rayWall setget ,getRayWall

func _ready():
	stateStack.push_front($States/Idle)
	currentState = stateStack[0]
	stateName = 'idle'
	direction = 1
	

func _physics_process(delta):
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var jump = Input.is_action_just_pressed("ui_accept")
	var up = Input.is_action_pressed("ui_up")
	var jumpRelease = Input.is_action_just_released("ui_accept")
	var run = Input.is_action_pressed("run")
	var runRelease = Input.is_action_just_released("run")
	
	rayWall = $RayCastWall.is_colliding()
	onWall = $WallDetect.get_overlapping_bodies()
	
	if not stateName in ['death','stagger']:
		if left:
			direction = -1
			if is_on_floor() and not run:
				changeState('walk')
				currentState.update(direction,self,delta)
			if is_on_floor() and run:
				changeState('run')
				currentState.update(direction,self,delta)
			if onWall and $RayCastWall.rotation_degrees == 90:
				changeState('climb')
				currentState.update(direction,self,delta)
			if stateName == 'jump':
				currentState.moveJumping(direction,self)
		
		elif right:
			direction = 1
			if is_on_floor() and not run:
				changeState('walk')
				currentState.update(direction,self,delta)
			if is_on_floor() and run:
				changeState('run')
				currentState.update(direction,self,delta)
			if onWall and $RayCastWall.rotation_degrees == -90:
				changeState('climb')
				currentState.update(direction,self,delta)
			if stateName == 'jump':
				currentState.moveJumping(direction,self)
		
		else:
			if is_on_floor() and not down:
				changeState('idle')
				currentState.update(self,delta)
	
		if jump:
			changeState('jump')
			currentState.update(direction,self,delta)
		if not is_on_floor() and not stateName in ['death','climb']:
			changeState('jump')
			currentState.update(direction,self,delta)
		
		if down:
			if is_on_floor():
				changeState('crouch')
			currentState.update(direction,self,delta)
		
		
	
	if stateName == 'death':
		currentState.update(self,delta)
	
	if stateName == 'stagger':
		currentState.update(direction,self,delta)



func _input(event):
	if stateName == 'idle':
		if event.is_action_pressed("ui_up") and not event.is_echo():
			currentState.lookUp(self)
		if event.is_action_released("ui_up"):
			currentState.resetLookUp()
	
	if stateName == 'climb':
		if event.is_action_released("ui_right") and $RayCastWall.rotation_degrees == -90:
			changeState('jump')
		if event.is_action_released("ui_left") and $RayCastWall.rotation_degrees == 90:
			changeState('jump')
	

func _on_SpriteAnim_animation_finished(anim_name):
	if stateName == 'stagger':
		stateName = currentState._on_SpriteAnim_animation_finished(anim_name)
		changeState(stateName)

func _on_DeathTimer_timeout():
	currentState.respawn(self,direction)
	changeState('idle')

########### State Machine #############

func changeState(name):
	if name == stateName:
		return
	currentState.exit(self)
	
	if name == "previous":
		stateStack.pop_front()
	elif name in ['stagger','jump','attack']:
		stateStack.push_front(statesMap[name])
	else:
		var newState = statesMap[name]
		stateStack[0] = newState
	
	currentState = stateStack[0]
	if name != 'previous':
		stateName = currentState.enter(self)

################################## GETERS AND SETTERS ########################################
func getOnWall():
	return onWall

func getRayWall():
	return rayWall


