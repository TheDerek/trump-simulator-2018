extends RigidBody2D

const Bullet = preload("../bullet/bullet.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 400
export var health = 5
export var walk_range = 550
onready var animation = get_node('animation')

func _ready():
	animation.play("walk_left")
	connect("body_entered", self, 'on_collision')
	add_to_group('enemies')

func on_collision(body):
	print('Collided with body!')
	if !body.is_in_group('bullets'):
		return

	if !is_in_group(body.target_group):
		print('Canont hurt me with ' + body.target_group)
		body.queue_free()
		var bullet = Bullet.instance()
		bullet.position = self.position

		var translate_x = -50;
		bullet.translate(Vector2(translate_x, 0))
		bullet.apply_impulse(Vector2(), Vector2(-50000 * get_process_delta_time(), 0))
		#bullet.set_applied_torque(6000)
		bullet.rotate(randf() * 2 * PI)

		get_tree().get_root().add_child(bullet)

		return

	apply_impulse(Vector2(), Vector2(10000 * get_process_delta_time(), -10000 * get_process_delta_time()))
	health -= 1
	body.queue_free()
	print(health)

	if health <= 0:
		var fly = 20000
		set_applied_torque(400)
		linear_damp = -1
		apply_impulse(Vector2(), Vector2(fly * get_process_delta_time(), -fly * get_process_delta_time()))
		queue_free()


func _process(delta):
	if !global_position.y < 520:
		if global_position.x - global.player_pos.x < walk_range:
			apply_impulse(Vector2(), Vector2(-speed * delta, 0))
