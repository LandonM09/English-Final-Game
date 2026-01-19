extends CharacterBody2D


var SPEED = 1200.0
var JUMP_VELOCITY = -700.0
var timea = 1
@export var wall_jump_force := Vector2(300, -350)
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_shift") and timea == 1.0 :
		SPEED = SPEED * 30
		timea = timea - 1
		
		
			
	else:
		SPEED = 700
	if Input.is_action_pressed("ui_right") :
		anim_player.play("walk")
	elif Input.is_action_pressed("ui_left"):
		if anim_player.current_animation != "walk":
			anim_player.play_backwards("walk")
	else:
		anim_player.play("idle")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if timea < 1.0:
		timea = timea + 0.02
		
	else:
		timea = 1
	if Input.is_action_just_pressed("ui_accept") and is_on_wall() and not is_on_floor():
		var wall_dir := get_wall_normal().x
		velocity.x = wall_dir * wall_jump_force.x
		velocity.y = wall_jump_force.y

	move_and_slide()
