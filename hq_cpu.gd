extends Node2D

const COST = 10
const MAX = 8
func interact():
	if GameManager.cpu_count >= MAX:
		print("MAX CPUs reached!")
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_cpu(get_node("/root/Main/Components/CPUs"))
		GameManager.save_game()
		print("CPU unlocked!")
	else:
		print("Not enough money!")
