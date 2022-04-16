extends Actor

export var stomp_impulse = 1000.0

func _on_anemydetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_anemydetector_body_entered(body: Node) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	$AnimatedSprite.play("idol")
	
	
func get_direction() ->Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 
		if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
	if Input.get_action_strength("move_right"):
		$AnimatedSprite.play("walk")
			
		if Input.get_action_strength("move_left"):
			$AnimatedSprite.play("walk")
			
			


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	)-> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

onready var _animation_player = $AnimatedSprite
func _process(_delta):
		
	if Input.is_action_pressed("ui_right"):
		_animation_player.play("walk")
	else:
		_animation_player.play("idol")

	if Input.is_action_pressed("ui_left"):
		_animation_player.play("walk")




