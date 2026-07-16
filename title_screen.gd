extends Control

@onready var title = $VBoxContainer/TitleLabel

const FINAL_TEXT = "Computer Building Tycoon"

const CHARS ="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*<>?|;"

func _ready():
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
