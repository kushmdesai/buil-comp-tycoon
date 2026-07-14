extends Node2D

func interact():
	if GameManager.overclock_level >= GameManager.OVERCLOCK_MAX:
		print("Overclock maxed!")
		return
	
	var cost = GameManager.get_next_overclock_cost()
	if GameManager.money >= cost:
		GameManager.money -= cost
		GameManager.overclock_level += 1
		GameManager.save_game()
		
		var main = get_node("/root/Main")
		main.refresh_overclock_visuals()
		
		print("Overclocked to level ", GameManager.overclock_level)
	else:
		print("Not enough money!")
