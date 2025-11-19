extends Node3D


@onready var animation_player = $characters/character

func _process(_delta: float) -> void:
	$weapons/weapon.play(GameSettings.active_weapon)
	$characters/character.play(GameSettings.active_character)
