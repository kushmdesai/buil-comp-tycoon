extends Node2D

@onready var all_parts = $"all-parts"
@onready var max_overclock = $"max-overclock"
@onready var thousand_dollars = $"thousand-dollars"

func _ready():
	GameManager.achievement_sprites = self

func show_sprite(sprite_name):
	if sprite_name == "all":
		all_parts.visible = true
		
	if sprite_name == "max":
		max_overclock.visible = true
		
	if sprite_name == "$":
		thousand_dollars.visible = true
