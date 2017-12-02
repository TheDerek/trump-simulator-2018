extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 400
onready var animation = get_node('animation')

var last_direction = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var direction = 0;
	
	if Input.is_action_pressed("run_right"):
		direction += 1;
	
	if Input.is_action_pressed("run_left"):
		direction -=1;
	
	if direction == 1:
		apply_impulse(Vector2(), Vector2(speed * delta, 0))
		if animation.get_current_animation() != 'run_right':
			animation.set_current_animation('run_right')
			
		if not animation.is_playing():
			animation.play()
		
	if direction == -1:
		apply_impulse(Vector2(), Vector2(-speed * delta, 0))
		if animation.get_current_animation() != 'run_left':
			animation.set_current_animation('run_left')
			
		if not animation.is_playing():
			animation.play()
			
	if direction == 0:
		if last_direction == 1:
			animation.set_current_animation('stand_right')
		
		if last_direction == -1:
			animation.set_current_animation('stand_left')
	
	if direction != 0:
		last_direction = direction