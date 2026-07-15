extends CharacterBody2D

var current_shop = null
const SPEED = 100

func _physics_process(delta):
	var found_shop = null
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
	update_interaction_prompt()

func _input(event):
	if event.is_action_pressed("interact"):
		for body in $InteractionZone.get_overlapping_bodies():
			if body.is_in_group("shop_npc"):
				body.get_parent().interact()

func update_interaction_prompt():
	var found_shop = null	
	for body in $InteractionZone.get_overlapping_bodies():
		if body.is_in_group("shop_npc"):
			found_shop = body.get_parent()
			break
	
	if found_shop != current_shop:
		if current_shop:
			current_shop.hide_prompt()
		if found_shop:
			found_shop.show_prompt()
		current_shop = found_shop
