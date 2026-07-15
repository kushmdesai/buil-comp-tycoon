extends Node2D

@onready var prompt = $PromptLabel

func show_prompt():
	var cost = GameManager.get_overclock_cost()
	
	if cost == null:
		prompt.text = "MAX OVERCLOCK"
	else:
		prompt.text = "Press E - $" + str(cost)
	prompt.visible = true
	
func hide_prompt():
	prompt.visible = false

func interact():
	if GameManager.overclock_level >= GameManager.OVERCLOCK_MAX:
		GameManager.show_feedback("Overclock Maxed!", Color.RED)
		return
	
	var cost = GameManager.get_overclock_cost()
	if GameManager.money >= cost:
		GameManager.money -= cost
		GameManager.overclock_level += 1
		GameManager.save_game()
		
		var main = get_node("/root/Main")
		main.refresh_overclock_visuals()
		
		GameManager.show_feedback("Overclocked to Lv%d!" % GameManager.overclock_level, Color.GREEN)
	else:
		GameManager.show_feedback("Not enough money!", Color.RED)
