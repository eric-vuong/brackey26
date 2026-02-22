extends CharacterBody2D

const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var main: Main = get_tree().get_nodes_in_group("Main")[0]
func _physics_process(delta: float) -> void:
	if main.can_move == true:
		process_movement()
		process_animation()
		move_and_slide()

func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
			velocity = Vector2.ZERO
		
func set_dir(dir: String):
	match dir:
		"right":
			last_direction = Vector2.RIGHT
		"left":
			last_direction = Vector2.LEFT
		
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)
		
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
