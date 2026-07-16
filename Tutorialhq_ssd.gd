extends Node2D

@onready var tutorial = get_tree().current_scene.get_node("TutorialManager")
@onready var ssd = $"../Start-SSD"

func _ready():
	ssd.visible = false
	
	for child in ssd.get_children():
		if child is CollisionShape2D:
			child.disabled = true
			
func interact():
	if tutorial.ssd_bought:
		return
		
	if tutorial.stage == 3:
		tutorial.ssd_bought = true
		
		ssd.visible = true
		
		for child in ssd.get_children():
			if child is CollisionShape2D:
				child.disabled = false
				
		tutorial.show_dialogue(
			"SYSTEM",
			"SSD Initialized!\nYou may return to the Technician"
		)

func _on_interaction_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.hide_dialogue()
		tutorial.hide_prompt()


func _on_interaction_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		tutorial.show_prompt("Press E to interact")
