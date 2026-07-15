extends Control

func _ready():
	GameManager.hud = self

func _process(delta):
	$MoneyLabel.text = "$" + str(snappedf(GameManager.money, 0.01))
	
func show_feedback(message: String, color: Color):
	$MessageLabel.text =  message
	$MessageLabel.modulate = color
	
	$MessageLabel.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_interval(3.0)
	tween.tween_property($MessageLabel, "modulate:a", 0.0, 1.0)
