extends CharacterBody2D

const SPEED = 100

func _physics_process(delta):
	var position = global_position
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _input(event):
	if event.is_action_pressed("interact"):
		print("e")
		for body in $InteractionZone.get_overlapping_bodies():
			if body.is_in_group("shop_npc"):
				body.get_parent().interact()
