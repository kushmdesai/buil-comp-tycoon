extends Node2D

@onready var finish_screen = $FinishScreen
@onready var finish_overlay = $FinishScreen/ColorRect

func _ready():
	finish_screen.visible = false
	GameManager.load_game()
	refresh_overclock_visuals()
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
			
func show_finish_screen():
	finish_screen.visible = true
	
	$FinishScreen/ColorRect/TerminalLabel.text = ""
	
	finish_overlay.modulate.a = 0.0
	
	var fade_in = create_tween()
	fade_in.tween_property(finish_overlay, "modulate:a", 1.0, 2.0)
	
	await fade_in.finished
	
	await type_text("""
SYSTEM DIAGNOSTICS
CPU..........MAX
RAM..........MAX
SSD..........MAX
PERFOMANCE...MAX

SYSTEM STATUS:
COMPLETE


All components installed.
Maximum performance achieved.

You have built the
ultimate machine.


THANK YOU FOR PLAYING.
""")

	await get_tree().create_timer(10.0).timeout
	var fade_out = create_tween()
	fade_out.tween_property(finish_overlay, "modulate:a", 0.0, 2.0)
	
	await fade_out.finished
	
	finish_screen.visible = false
	GameManager.game_completed = true
	GameManager.save_game()

func type_text(text: String):
	$FinishScreen/ColorRect/TerminalLabel.text = ""
	
	for character in text:
		$FinishScreen/ColorRect/TerminalLabel.text += character
		await get_tree().create_timer(0.03).timeout
