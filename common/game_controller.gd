extends Node

var score = 0

signal score_changed(new_value)

func on_get_coin():
	score += 1
	emit_signal("score_changed", score)
