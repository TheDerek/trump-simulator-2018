extends RigidBody2D

const Bullet = preload("../bullet/bullet.tscn")

export var speed = 400
export var health = 10
export var fire_rate = 0.5
onready var animation = get_node('animation')

var last_direction = 1
var selected = 0
var current_fire_time = 0

func _ready():
	connect("body_entered", self, 'on_collision')

func on_collision(body):
	print('Collied with :' + str(body))
	if body.is_in_group('enemies'):
		print('Hit by an enemy!')
		apply_impulse(Vector2(), Vector2(-10000 * get_process_delta_time(), -10000 * get_process_delta_time()))

	if body.is_in_group('bullets'):
		print('Hit by a bullet!')
		apply_impulse(Vector2(), Vector2(-10000 * get_process_delta_time(), -10000 * get_process_delta_time()))
		body.queue_free()
		health -= 1

func _process(delta):
	var direction = 0;
	current_fire_time += delta
	global.player_pos = self.global_position

	if Input.is_action_pressed("run_right"):
		direction += 1;

	if Input.is_action_pressed("run_left"):
		direction -=1;
	
	if direction == 1 and !global_position.y < 520:
		apply_impulse(Vector2(), Vector2(speed * delta, 0))
		if animation.get_current_animation() != 'run_right':
			animation.set_current_animation('run_right')

		if not animation.is_playing():
			animation.play()

	if direction == -1 and !global_position.y < 520:
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

	if Input.is_action_just_pressed('select_0'):
		selected = 0;
		global.emit_signal('selected', 0)

	if Input.is_action_just_pressed('select_1'):
		selected = 1;
		global.emit_signal('selected', 1)

	if Input.is_action_just_pressed('select_2'):
		selected = 2;
		global.emit_signal('selected', 2)

	if Input.is_action_just_released('shoot'):
		if current_fire_time < fire_rate:
			return

		current_fire_time = 0

		var bullet = Bullet.instance()
		#bullet.global_translate()
		bullet.position = self.position

		var translate_x = 70;
		if last_direction == -1:
			translate_x = -translate_x

		bullet.target_group = global.topics[selected]
		print('Firing bullet of type: ' + global.topics[selected])
		bullet.translate(Vector2(translate_x, 0))
		bullet.apply_impulse(Vector2(), Vector2(last_direction * 50000 * delta, 0))
		#bullet.set_applied_torque(6000)
		bullet.rotate(randf() * 2 * PI)

		get_tree().get_root().add_child(bullet)
		global.emit_signal('shuffle_tweets')
		pass