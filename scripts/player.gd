extends CharacterBody2D

# Inspired by https://www.youtube.com/watch?v=uNReb-MHsbg

const ACC = 900
const FRI = 10
const MAX_SPEED = 80

enum {STANDING, MOVING}
var state = STANDING

func _physics_process(delta):
	move(delta)

func move(delta):
	var input_vector = Input.get_vector("left_movement", "right_movement", "up_movement", "down_movement")
	if input_vector == Vector2.ZERO:
		state = STANDING
		apply_friction(delta)
	else:
		state = MOVING
		apply_movement(input_vector, delta)
	move_and_slide()


func apply_movement(input_vector, delta) -> void:
	velocity += input_vector * ACC * delta
	velocity = velocity.limit_length(MAX_SPEED)

func apply_friction(delta) -> void:
	if velocity.length() > FRI * delta:
		velocity -= velocity.normalized() * FRI * delta
	else:
		velocity = Vector2.ZERO
