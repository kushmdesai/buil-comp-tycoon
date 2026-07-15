extends Node2D


const MAX = 4

@onready var prompt = $PromptLabel

func show_prompt():
	prompt.text = "Press E - $" + str(GameManager.get_ssd_cost())
	prompt.visible = true

func hide_prompt():
	prompt.visible = false
func interact():
	var COST = GameManager.get_ssd_cost()
	if GameManager.ssd_count >= MAX:
		GameManager.show_feedback("MAX SSDs reached!", Color.RED)
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_ssd(get_node("/root/Main/Components/SSDs"))
		GameManager.show_feedback("SSD unlocked!", Color.GREEN)
		GameManager.check_achievemetns()
		GameManager.save_game()
	else:
		GameManager.show_feedback("Not enough money!", Color.RED)
