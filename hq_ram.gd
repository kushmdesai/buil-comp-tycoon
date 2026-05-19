extends Node2D

const COST = 5
const MAX = 18
func interact():
	if GameManager.ram_count >= MAX:
		print("MAX RAMs reached!")
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_ram(get_node("/root/Main/Components/RAMs"))
		print("RAM unlocked!")
	else:
		print("Not enough money!")
