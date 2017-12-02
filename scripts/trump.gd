extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("run_left"):
		apply_impulse(Vector2(), Vector2(speed * delta, 0))