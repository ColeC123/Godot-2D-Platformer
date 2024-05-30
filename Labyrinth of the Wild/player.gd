extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

var was_on_floor

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal is_swimming
signal is_speeding(y_val)

var swimming = false
var speeding = false


func _physics_process(delta):
	
	if speeding:
		velocity.y = 0
	# Add the gravity.
	if not is_on_floor() and !swimming and !speeding:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !speeding:
		velocity.y = JUMP_VELOCITY
		$jumpSfx.play()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if !(($AnimatedSprite2D.get_animation() == "jump1" or $AnimatedSprite2D.get_animation() == "jump4") and $AnimatedSprite2D.is_playing() == true):
			$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		if !(($AnimatedSprite2D.get_animation() == "jump1" or $AnimatedSprite2D.get_animation() == "jump4") and $AnimatedSprite2D.is_playing() == true):
			$AnimatedSprite2D.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("jump") and is_on_floor:
		$AnimatedSprite2D.play("jump1")
		
	if !is_on_floor() and velocity.y < 0:
		if !(($AnimatedSprite2D.get_animation() == "jump1" or $AnimatedSprite2D.get_animation() == "jump4") and $AnimatedSprite2D.is_playing() == true):
			$AnimatedSprite2D.play("jump2")
	elif !is_on_floor() and velocity.y > 0:
		if !(($AnimatedSprite2D.get_animation() == "jump1" or $AnimatedSprite2D.get_animation() == "jump4") and $AnimatedSprite2D.is_playing() == true):
			$AnimatedSprite2D.play("jump3")
		
	if is_on_floor() == true and was_on_floor == false:
		$AnimatedSprite2D.play("jump4")
		
	was_on_floor = is_on_floor()
	
	if swimming == true:
		velocity.y += -100 * delta
		
	if speeding == true:
		velocity.x += 10000 * delta

	move_and_slide()


func _on_is_swimming():
	swimming = !swimming


func _on_is_speeding(y_val):
	speeding = !speeding
	if speeding:
		position.y = y_val
