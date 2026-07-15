extends Node

var cpu_count = 0
var ram_count = 0
var ssd_count = 0
var money = 0
var overclock_level = 0

var autosave_timer = 0.0
const SAVE_PATH = "user://savegame.json"

const CPU_INCOME = 0.1
const RAM_INCOME = 0.05
const SSD_INCOME = 0.2

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
var achievement_sprites = null

var achievements = {
	"all_parts": false,
	"max_overclock": false,
	"thousand_dollars": false
}

func save_game():
	var data = {
		"cpu_count": cpu_count,
		"ram_count": ram_count,
		"ssd_count": ssd_count,
		"overclock_level": overclock_level,
		"money": money,
		"achievements": achievements
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
		achievements = data.get("achievements", achievements)
		update_achievements()

func _process(delta):
	time_accumulated += delta
	autosave_timer += delta

	if time_accumulated >= 1:
		time_accumulated -= 1.0
		_tick()

	if autosave_timer >= 60.0:
		autosave_timer -= 60.0
		save_game()

func _tick():
	var multiplier = get_overclock_multiplier()
	money += ((cpu_count + 1) * CPU_INCOME) * multiplier
	money += ((ram_count + 1) * RAM_INCOME) * multiplier
	money += ((ssd_count + 1) * SSD_INCOME) * multiplier
	check_achievemetns()

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

func show_feedback(message: String, color: Color, duration:= 3.0):
	if hud:
		hud.show_feedback(message, color, duration)

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

func get_income_per_second():
	var multiplier = get_overclock_multiplier()
	
	var income_per_tic = (
		((cpu_count + 1) * CPU_INCOME) +
		((ram_count + 1) * RAM_INCOME) +
		((ssd_count + 1) * SSD_INCOME)
	) * multiplier
	
	return income_per_tic

func check_achievemetns():
	if cpu_count >= 8 and ram_count >=18 and ssd_count >= 4:
		if not achievements["all_parts"]:
			achievements["all_parts"] = true
			show_feedback("Achievement Unlocked!\n Fully Equipped", Color.AQUA)
			update_achievements()
		
	if overclock_level >= OVERCLOCK_MAX:
		if not achievements["max_overclock"]:
			achievements["max_overclock"] = true
			show_feedback("Achievemnt Unlocked!\n Maximum Performance", Color.AQUA)
			update_achievements()
		
	if money >= 1000:
		if not achievements["thousand_dollars"]:
			achievements["thousand_dollars"] = true
			show_feedback("Achievemnt Unlocked!\n High Roller", Color.AQUA)
			update_achievements()

func update_achievements():
	print("updating achievemnts")
	if achievement_sprites:
		print("file found")
		if achievements["all_parts"]:
			print("print updating all parts")
			achievement_sprites.show_sprite("all")
		if achievements["max_overclock"]:
			print("updating max overclock")
			achievement_sprites.show_sprite("max")
		if achievements["thousand_dollars"]:
			print("updating thousand dollars")
			achievement_sprites.show_sprite("$")
