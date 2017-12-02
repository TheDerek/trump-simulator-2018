extends RigidBody2D

var target_group = ''
var timer = 0;
export var timeout = 2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timer += delta;

	if timer > timeout:
		queue_free()