extends Node2D

func _ready():
	GameManager.load_game()
	print(GameManager.cpu_count)
	for cpu in $Components/CPUs.get_children():
		if cpu.name.begins_with("CPU-"):
			cpu.visible = false
			_disable_collision(cpu)
			
	for ram in $Components/RAMs.get_children():
		if ram.name.begins_with("RAM-"):
			ram.visible = false
			_disable_collision(ram)
			
	for ssd in $Components/SSDs.get_children():
		if ssd.name.begins_with("SSD-"):
			ssd.visible = false
			_disable_collision(ssd)
			
	for i in range(1, GameManager.cpu_count+1):
		var cpu = $Components/CPUs.get_node_or_null("CPU-" + str(i))
		if cpu:
			cpu.visible = true
			_enable_collision(cpu)
			
	for i in range(1, GameManager.ram_count+1):
		var ram = $Components/RAMs.get_node_or_null("RAM-" + str(i))
		if ram:
			ram.visible = true
			_enable_collision(ram)
			
	for i in range(1, GameManager.ssd_count+1):
		var ssd = $Components/SSDs.get_node_or_null("SSD-" + str(i))
		if ssd:
			ssd.visible = true
			_enable_collision(ssd)
			
func _disable_collision(node: Node):
	for child in node.get_children():
		if child is CollisionShape2D:
			child.disabled = true

func _enable_collision(node: Node):
	for child in node.get_children():
		if child is CollisionShape2D:
			child.disabled = false

func refresh_overclock_visuals():
	var stages_root = $Components/Shop/Shop/OverclockStages
	for i in range(1, GameManager.OVERCLOCK_MAX + 1):
		var stage = stages_root.get_node_or_null("Lv%d" % i)
		if stage:
			var is_unlocked = GameManager.overclock_level >= i
			stage.get_node("Unlocked").visible = is_unlocked
			stage.get_node("Locked").visible = not is_unlocked
