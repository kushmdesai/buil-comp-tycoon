extends Node2D

@onready var tutorial = get_tree().current_scene.get_node("TutorialManager")

func interact():
	tutorial.show_dialogue(
		"Technician",
		"You made it! I wanted to talk to you\nabout overclocking its good way to\nmake quick money it allows it get upto\na 2x multiplier on the money you earn.\nMeet me at the original location\nI think you're ready!"
	)
	


func _on_dialogue_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if  tutorial.stage == 4:
			tutorial.hide_dialogue()
			tutorial.return_to_start()
			tutorial.hide_prompt()
			tutorial.overclock_done = true


func _on_dialogue_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if tutorial.stage == 4:
			tutorial.show_prompt("Press E to interact")
