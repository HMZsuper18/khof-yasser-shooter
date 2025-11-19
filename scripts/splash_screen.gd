extends Control

func _ready():
	$AnimationPlayer.play("splash screen")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name: String):
	get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
