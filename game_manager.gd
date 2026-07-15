extends Node

var cpu_count = 0
var ram_count = 0
var ssd_count = 0
var money = 0
var overclock_level = 0

const SAVE_PATH = "user://savegame.json"

const CPU_INCOME = 0.5
const RAM_INCOME = 0.25
const SSD_INCOME = 1.0

const OVERCLOCK_MAX = 4
const OVERCLOCK_COSTS = [50, 100, 250, 300]
const OVERCLOCK_MULTIPLIERS = [1.0, 1.1, 1.25, 1.5, 2.0]

const CPU_BASE_COST = 15
const RAM_BASE_COST = 8
const SSD_BASE_COST = 40

const CPU_MULTIPLIER = 1.35
const RAM_MULTIPLIER = 1.18
const SSD_MULTIPLIER = 1.45

var time_accumulated = 0.0

var hud = null

func save_game():
	var data = {
		"cpu_count": cpu_count,
		"ram_count": ram_count,
		"ssd_count": ssd_count,
		"overclock_level": overclock_level,
		"money": money
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if data:
		cpu_count = int(data["cpu_count"])
		ram_count = int(data["ram_count"])
		ssd_count = int(data["ssd_count"])
		overclock_level = int(data.get("overclock_level", 0))
		money = data["money"]
		
func _process(delta):
	time_accumulated += delta
	if time_accumulated >= 5:
		time_accumulated = 0.0
		_tick()
		
func _tick():
	var multiplier = get_overclock_multiplier()
	money += ((cpu_count + 1) * CPU_INCOME) * multiplier
	money += ((ram_count + 1) * RAM_INCOME) * multiplier
	money += ((ssd_count + 1) * SSD_INCOME) * multiplier
	save_game()

func unlock_next_cpu(cpu_group: Node):
	cpu_count += 1
	var target = cpu_group.get_node_or_null("CPU-" + str(cpu_count))
	print("Looking for: CPU-" + str(cpu_count))
	print("Foung: ", target)
	if target:
		target.visible = true
		print("Set Visible")
		for child in target.get_children():
			if child is CollisionShape2D:
				child.disabled = false
		
func unlock_next_ram(ram_group: Node):
	ram_count += 1
	var target = ram_group.get_node_or_null("RAM-" + str(ram_count))
	if target:
		target.visible = true
		for child in target.get_children():
			if child is CollisionShape2D:
				child.disabled = false
		
func unlock_next_ssd(ssd_group: Node):
	ssd_count += 1
	var target = ssd_group.get_node_or_null("SSD-" + str(ssd_count))
	if target:
		target.visible = true
		for child in target.get_children():
			if child is CollisionShape2D:
				child.disabled = false

func get_overclock_multiplier() -> float:
	return OVERCLOCK_MULTIPLIERS[overclock_level]

func show_feedback(message: String, color: Color):
	if hud:
		hud.show_feedback(message, color)

func get_cpu_cost():
	return round(CPU_BASE_COST * pow(CPU_MULTIPLIER, cpu_count))

func get_ram_cost():
	return round(RAM_BASE_COST * pow(RAM_MULTIPLIER, ram_count))

func get_ssd_cost():
	return round(SSD_BASE_COST * pow(SSD_MULTIPLIER, ssd_count))

func get_overclock_cost():
	if overclock_level >= OVERCLOCK_MAX:
		return null
	return OVERCLOCK_COSTS[overclock_level]
