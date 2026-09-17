extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 30.0
const JUMP_VELOCITY = -200.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if 	is_on_floor():
	# Inverte a animação dependendo da direção
		if direction > 0:
			anim.flip_h = false
			anim.play ("walk")
		elif direction < 0:
			anim.flip_h = true
			anim.play("walk")
		
		else:
		
			anim.play("idle")
	else:
		anim.play("jump")
		
	# Aplica o movimento e colisões (deve ficar alinhado com as variáveis principais)
	move_and_slide()
