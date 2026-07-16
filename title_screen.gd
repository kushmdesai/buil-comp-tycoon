extends Control

@onready var title = $VBoxContainer/TitleLabel

const FINAL_TEXT = "Computer Building Tycoon"

const CHARS ="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*<>?|;"

func _ready():
	if not FileAccess.file_exists(GameManager.SAVE_PATH):
		$VBoxContainer/ContinueButton.disabled = true
	$ConfirmPanel.visible = false
	await glitch_tile()

func glitch_tile():
	var rng = RandomNumberGenerator.new()
	
	for i in range(20):
		var text = ""
		
		for j in FINAL_TEXT.length():
			if rng.randf() < float(i) / 20:
				text += FINAL_TEXT[j]
			else:
				text += CHARS[rng.randi_range(0, CHARS.length()-1)]

		title.text = text
		
		await get_tree().create_timer(0.04).timeout
		
	title.text = FINAL_TEXT


func _on_new_game_button_pressed() -> void:
	$ConfirmPanel.visible = true


func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_yes_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://Tutorial.tscn")


func _on_no_button_pressed() -> void:
	$ConfirmPanel.visible = false
