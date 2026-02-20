extends CharacterBody2D
class_name Platformer
# Code modified from
# https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html
@export var speed: float = 700.0
@export var jump_speed: float = -1300.0
@export var gravity_mod: float = 3.0
## Should be positive number
@export var max_falling_spd: float = 0.0
## How big to scale. Must be int because pixel art
@export var scale_mod: int = 3
## When to play air animation between fall and jump
var v_spd_threshold: int = 400
## Gravity is set on ready
var gravity
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_mod
	scale = scale * scale_mod
	$CanInteract.hide()

func flip_sprite(flipped: bool = true):
	if flipped:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func can_interact(can: bool = true):
	if can:
		$CanInteract.show()
	else:
		$CanInteract.hide()
## Set x velocity to 0
func stop():
	velocity.x = 0
func _physics_process(delta):
	
	# Add the gravity.
	velocity.y += gravity * delta
	# Clamp it
	if max_falling_spd != 0.0:
		velocity.y = clamp(velocity.y, -99999, max_falling_spd)

	if is_on_floor():
		# Walking animation if on floor and moving
		if velocity.x != 0:
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")
		# Jump
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("jump"):
			if main.can_move:
				velocity.y = jump_speed
	else:
		# In the air
		# Do fall or jump animation
		if abs(velocity.y) < v_spd_threshold:
			$AnimatedSprite2D.play("air")
			#print("AIR", velocity.y)
		elif velocity.y > 0:
			$AnimatedSprite2D.play("fall")
			#print("FALL", velocity.y )
		elif velocity.y < 0:
			$AnimatedSprite2D.play("jump")
			#print("JUMP", velocity.y )
	

	# Get the input direction.
	if main.can_move:
		var direction = Input.get_axis("left", "right")
		velocity.x = direction * speed

	move_and_slide()
	
	# Turn character left or right based on velocity
	if velocity.x != 0:
		if velocity.x < 0: # Left
			flip_sprite(true)
		elif velocity.x > 0: # Right
			flip_sprite(false)
