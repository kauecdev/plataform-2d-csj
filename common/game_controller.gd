extends Node

var score = 0

signal score_changed(new_value)

func on_get_coin():
	score += 1
	print(score)
	emit_signal("score_changed", score)
