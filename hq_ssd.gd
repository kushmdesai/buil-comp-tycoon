extends Node2D

const COST = 25
const MAX = 4
func interact():
	if GameManager.ssd_count >= MAX:
		print("MAX SSDs reached!")
		return
	if GameManager.money >= COST:
		GameManager.money -= COST
		GameManager.unlock_next_ssd(get_node("/root/Main/Components/SSDs"))
		print("SSD unlocked!")
	else:
		print("Not enough money!")
