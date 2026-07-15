extends Node2D

const COST = 10
const MAX = 8
func interact():
	if GameManager.cpu_count >= MAX:
		GameManager.show_feedback("Max CPUs Reached!", Color.RED)
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_cpu(get_node("/root/Main/Components/CPUs"))
		GameManager.save_game()
		GameManager.show_feedback("CPU Unlocked!", Color.GREEN)
	else:
		GameManager.show_feedback("Not Enough Money!", Color.RED)
