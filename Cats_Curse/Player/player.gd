extends Node

onready var statesMap = {'idle' : $States/Idle,
 'walk' : $States/Walk,
 'jump' : $States/Jump,
 'crouch' : $States/Crouch,
 'stagger' : $States/Stagger,
 'death' : $States/Death,
 'attack' : $States/Attack}

var stateStack = []
var currentState = null
var stateName 
var onWall setget ,getOnWall
var direction

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
	var upRelease = Input.is_action_just_released("ui_up")
	var jumpRelease = Input.is_action_just_released("ui_accept")
	
	# checa para wall jump
	onWall = $RayCastWall.is_colliding() 
	
	
	if stateName != 'death':
		if left:
			direction = -1
			if is_on_floor():
				changeState('walk')
				currentState.update(direction,self,delta)
			if stateName == 'jump':
				currentState.moveJumping(direction,self)
		elif right:
			direction = 1
			if is_on_floor():
				changeState('walk')
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
		if jumpRelease and stateName == 'jump':
			currentState.controlJump(self,delta)
		if not is_on_floor() and stateName != 'death':
			changeState('jump')
			currentState.update(direction,self,delta)
		
		if down:
			changeState('crouch')
			currentState.update(self)
	
	if stateName == 'death':
		currentState.update(self,delta)



func _input(event):
	if stateName == 'idle':
		if event.is_action_pressed("ui_up") and not event.is_echo():
			currentState.lookUp(self)
		if event.is_action_released("ui_up"):
			currentState.resetLookUp()



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