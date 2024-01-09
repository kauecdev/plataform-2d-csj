extends Node

signal health_changed(new_health)

var health = 5

func on_health_changed():
	emit_signal("health_changed")

