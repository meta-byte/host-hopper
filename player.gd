extends CharacterBody2D

@warning_ignore("narrowing_conversion")
@export var MAX_SPEED: int = 100.0
@export var ACCELERATION: int = 100
@export var FRICTION: int = 1200

@onready var axis:Vector2 = Vector2.ZERO

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.limit_length(MAX_SPEED)
	
func move(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
		
	move_and_slide()

func _physics_process(delta):
	move(delta)
