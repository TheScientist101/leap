extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -1000.0
var DOUBLE_JUMP = false

var SCORE = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not DOUBLE_JUMP):
		if not DOUBLE_JUMP:
			DOUBLE_JUMP = true
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(_delta: float) -> void:
	if is_on_floor():
		SCORE = max(SCORE, int(-position.y / 10))
	$"../CanvasLayer/Label".text = "Score: " + str(SCORE)
	
	if is_on_floor() or is_on_wall() or is_on_ceiling():
		DOUBLE_JUMP = false
