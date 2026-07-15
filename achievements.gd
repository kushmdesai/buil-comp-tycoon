extends Node2D

@onready var prompt = $PromptLabel

func show_prompt():
	prompt.text = "Press E"
	prompt.visible = true

func hide_prompt():
	prompt.visible = false

func interact():
	var unlocked = 0
	
	if GameManager.achievements["all_parts"]:
		unlocked += 1
		
	if GameManager.achievements["max_overclock"]:
		unlocked += 1
		
	if GameManager.achievements["thousand_dollars"]:
		unlocked += 1
		
	var message = "Achievemetns Unlocked %d/3\n\n" % unlocked
	
	message += "Fully Equipped "
	message += "[✓]\n" if GameManager.achievements["all_parts"] else "[ ]\n"
	message += "Maximum Performance "
	message += "[✓]\n" if GameManager.achievements["max_overclock"] else "[ ]\n"
	message += "High Roller "
	message += "[✓]\n" if GameManager.achievements["thousand_dollars"] else "[ ]\n"

	GameManager.show_feedback(message, Color.AQUA, 10.0)
