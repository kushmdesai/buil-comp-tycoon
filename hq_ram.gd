extends Node2D

const COST = 5
const MAX = 18

@onready var prompt = $PromptLabel

func show_prompt():
	prompt.text = "Press E - $" + str(COST)
	prompt.visible = true

func hide_prompt():
	prompt.visible = false

func interact():
	if GameManager.ram_count >= MAX:
		GameManager.show_feedback("MAX RAMs reached!", Color.RED)
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_ram(get_node("/root/Main/Components/RAMs"))
		GameManager.show_feedback("RAM unlocked!", Color.GREEN)
	else:
		GameManager.show_feedback("Not enough money!", Color.RED)
