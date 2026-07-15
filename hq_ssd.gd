extends Node2D

const COST = 25
const MAX = 4

@onready var prompt = $PromptLabel

func show_prompt():
	prompt.text = "Press E - $" + str(COST)
	prompt.visible = true

func hide_prompt():
	prompt.visible = false
func interact():
	if GameManager.ssd_count >= MAX:
		GameManager.show_feedback("MAX SSDs reached!", Color.RED)
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_ssd(get_node("/root/Main/Components/SSDs"))
		GameManager.show_feedback("SSD unlocked!", Color.GREEN)
	else:
		GameManager.show_feedback("Not enough money!", Color.RED)
