extends Node2D


const MAX = 8

@onready var prompt = $PromptLabel

func _ready():
	print(prompt)
	prompt.visible = true
	
func show_prompt():
	prompt.text = "Press E - $" + str(GameManager.get_cpu_cost())
	prompt.visible = true
	
func hide_prompt():
	prompt.visible = false

func interact():
	if GameManager.cpu_count >= MAX:
		GameManager.hud.play(GameManager.hud.error_sound)
		GameManager.show_feedback("Max CPUs Reached!", Color.RED)
		return
	var COST = GameManager.get_cpu_cost()
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.hud.play(GameManager.hud.buy_sound)
		GameManager.unlock_next_cpu(get_node("/root/Main/Components/CPUs"))
		GameManager.save_game()
		GameManager.show_feedback("CPU Unlocked!", Color.GREEN)
		GameManager.check_achievemetns()
		GameManager.save_game()
	else:
		GameManager.hud.play(GameManager.hud.error_sound)
		GameManager.show_feedback("Not Enough Money!", Color.RED)
