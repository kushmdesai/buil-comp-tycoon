extends Control

@export var feedback_scene: PackedScene
@onready var sfx = $SFXPlayer

var buy_sound = preload("res://sound-effects/cha-ching.mp3")
var error_sound = preload("res://sound-effects/buzzer.mp3")
var achievement_sound = preload("res://sound-effects/chime.mp3")
var overclock_sound = preload("res://sound-effects/power_up.mp3")

func _ready():
	GameManager.hud = self

func _process(delta):
	$MoneyLabel.text = "$" + str(snappedf(GameManager.money, 0.01))
	$IncomeLabel.text = "$" + str(snappedf(GameManager.get_income_per_second(), 0.01)) + "/s"
	
func show_feedback(message: String, color: Color, duration := 3.0):
	var label = feedback_scene.instantiate()
	
	label.text = message
	label.modulate = color
	label.modulate.a = 1.0
	
	$Messages.add_child(label)
	var tween = create_tween()
	tween.tween_interval(duration/2)
	tween.parallel().tween_property(label, "modulate:a", 0.0, duration/2)
	tween.parallel().tween_property(label, "position:y", label.position.y - 35, duration/4)
	
	tween.tween_callback(label.queue_free)

func play(sound):
	sfx.stream = sound
	sfx.play()
