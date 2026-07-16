extends Node2D

@onready var tutorial = get_tree().current_scene.get_node("TutorialManager")
@onready var cpu = $"../Start-CPU"

func _ready():
	cpu.visible = false
	
	for child in cpu.get_children():
		if child is CollisionShape2D:
			child.disabled = true
			
func interact():
	if tutorial.cpu_bought:
		return
	
	if tutorial.stage == 1:
		tutorial.cpu_bought = true
		
		cpu.visible = true
		
		for child in cpu.get_children():
			if child is CollisionShape2D:
				child.disabled = false
				
		tutorial.show_dialogue(
			"SYSTEM",
			"CPU detected!\nYou may return to the Technician"
		)

func _on_interaction_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.hide_dialogue()
		tutorial.hide_prompt()
		

func _on_interaction_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.show_prompt("Press E to interact")
