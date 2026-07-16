extends Node


var cpu_bought = false
var ram_bought = false
var ssd_bought = false
var overclock_done = false
var stage=0

@onready var dialogue_panel = get_parent().get_node("UI/DialoguePanel")
@onready var speaker_label = dialogue_panel.get_node("SpeakerLabel")
@onready var dialogue_label = dialogue_panel.get_node("DialougeLabel")
@onready var technician_start = get_parent().get_node("TutorialNPC")
@onready var technician_shop = get_parent().get_node("TutorialNPC-shop")
@onready var animation_player = get_parent().get_node("UI/Fadeout")
@onready var faderect = get_parent().get_node("UI/FadeRect")
@onready var prompt = get_parent().get_node("UI/InteractionPrompt")

func _ready():
	show_prompt("Welcome to the Tutorial\nVisit the NPC above you to begin!")
	technician_shop.visible = false
	faderect.color = Color(0,0,0,0)
	for child in technician_shop.get_children():
		if child is CollisionShape2D:
			child.disabled = true

func show_dialogue(speaker: String, text: String):
	dialogue_panel.visible = true
	speaker_label.text = speaker
	dialogue_label.text = text

func hide_dialogue():
	dialogue_panel.visible = false

func move_to_shop():
	technician_start.visible = false
	technician_shop.visible = true
	for child in technician_shop.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)
	for child in technician_start.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)
func return_to_start():
	technician_shop.visible = false
	technician_start.visible = true
	for child in technician_shop.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)
	for child in technician_start.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)

func finish_tutorial():
	hide_dialogue()
	animation_player.play("FadeOut")
	await animation_player.animation_finished
	GameManager.reset_game()
	GameManager.load_game()
	get_tree().change_scene_to_file("res://main.tscn")

func show_prompt(text):
	prompt.text = text
	prompt.visible = true
	
func hide_prompt():
	prompt.visible = false
