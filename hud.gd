extends Control

@export var feedback_scene: PackedScene

func _ready():
	GameManager.hud = self

func _process(delta):
	$MoneyLabel.text = "$" + str(snappedf(GameManager.money, 0.01))
	$IncomeLabel.text = "$" + str(snappedf(GameManager.get_income_per_second(), 2)) + "/s"
	
func show_feedback(message: String, color: Color):
	var label = feedback_scene.instantiate()
	
	label.text = message
	label.modulate = color
	label.modulate.a = 1.0
	
	$Messages.add_child(label)
	var tween = create_tween()
	tween.tween_interval(3.0)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 1.5)
	tween.parallel().tween_property(label, "position:y", label.position.y - 35, 1.5)
	
	tween.tween_callback(label.queue_free)
