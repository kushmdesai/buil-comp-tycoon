extends Node2D


const MAX = 18

@onready var prompt = $PromptLabel

func show_prompt():
	prompt.text = "Press E - $" + str(GameManager.get_ram_cost())
	prompt.visible = true

func hide_prompt():
	prompt.visible = false

func interact():
	var COST = GameManager.get_ram_cost()
	if GameManager.ram_count >= MAX:
		GameManager.hud.play(GameManager.hud.error_sound)
		GameManager.show_feedback("MAX RAMs reached!", Color.RED)
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.hud.play(GameManager.hud.buy_sound)
		GameManager.unlock_next_ram(get_node("/root/Main/Components/RAMs"))
		GameManager.show_feedback("RAM unlocked!", Color.GREEN)
		GameManager.check_achievemetns()
		GameManager.save_game()
	else:
		GameManager.hud.play(GameManager.hud.error_sound)
		GameManager.show_feedback("Not enough money!", Color.RED)
