extends Node2D

@onready var tutorial = get_tree().current_scene.get_node("TutorialManager")

func interact():
	
	if not tutorial.cpu_bought:
		tutorial.show_dialogue(
			"TECHNICIAN",
			"Welcome to Computer Building Tycoon.\n\nThis machine is empty.\nLet's install your first CPU.\n\nVisit CPU HQ to buy your first one!"
		)
		tutorial.stage = 1
		
	elif not tutorial.ram_bought:
		tutorial.show_dialogue(
			"TECHNICIAN",
			"Great work! Your CPU is installed.\nNow let's upgrade the memory\nVisit Ram HQ.\nIt should be just south of here."
		)
		tutorial.stage = 2
		
	elif not tutorial.ssd_bought:
		tutorial.show_dialogue(
			"TECHNICIAN",
			"Nice! The computer is starting to rock.\nYou'll need storage though\nVisit SSD HQ to obtain some\n It should be to the east of RAM HQ\njust past the shop"
		)
		tutorial.stage = 3
		
	elif not tutorial.overclock_done:
		tutorial.show_dialogue(
			"TECHNICIAN",
			"Excellent.\nYour PC is complete.\nI need to tell you something meet me\nat shop\nIts just west of the SSD HQ"
		)
		tutorial.stage = 4
	else:
		tutorial.show_dialogue(
			"TECHNICIAN",
			"I've taught you everything I know\nI think you're ready to start\nI'll be back later try to build the\nbiggest computer you can\nalso get a ton of money"
		)
		tutorial.stage = 5
		await get_tree().create_timer(5).timeout
		tutorial.finish_tutorial()
func _on_dialogue_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.hide_dialogue()
		tutorial.hide_prompt()
		if tutorial.stage == 4:
			tutorial.move_to_shop()



func _on_dialogue_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.show_prompt("Press E to interact")
