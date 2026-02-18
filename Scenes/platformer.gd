extends CharacterBody2D
class_name Platformer
# Code modified from
# https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html
@export var speed = 700.0
@export var jump_speed = -1300.0

## 980 x 3 For gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 3
func _ready():
	pass
func _physics_process(delta):
	
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	move_and_slide()
