extends Node2D

var screen_size
var player_size

var MIN_SPEED = 10
var MAX_SPEED = 220
var ACCELERATION = 20

var movement_speed = MIN_SPEED

func _ready():
	screen_size = get_viewport_rect().size
	player_size = get_node('player_sprite').get_texture().get_size()
	set_process(true)

func _get_normalized_direction():
	var any_pressed = false
	var direction = Vector2(0, 0)
	if (Input.is_action_pressed("player_move_left")):
		direction.x += -1
		any_pressed = true
	if (Input.is_action_pressed("player_move_right")):
		direction.x += 1
		any_pressed = true
	if (Input.is_action_pressed("player_move_up")):
		direction.y += -1
		any_pressed = true
	if (Input.is_action_pressed("player_move_down")):
		direction.y += 1
		any_pressed = true
	if not any_pressed:
		movement_speed = MIN_SPEED
		return Vector2(0, 0)
	else:
		return direction.normalized()

func _get_movement_vector(delta):
	var direction = self._get_normalized_direction()
	if movement_speed < MAX_SPEED:
		movement_speed += ACCELERATION
	else:
		movement_speed = MAX_SPEED
	return direction * delta * movement_speed

func _process(delta):
	var player = get_node('player_sprite')
	var curr_pos = player.get_pos()
	var movement_vector = self._get_movement_vector(delta)
	var new_pos = curr_pos + movement_vector
	player.set_pos(new_pos)
