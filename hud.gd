extends Control

func _process(delta):
	$MoneyLabel.text = "$" + str(snappedf(GameManager.money, 0.01))
