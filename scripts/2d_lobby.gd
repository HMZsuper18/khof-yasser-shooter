extends Control

func _ready() -> void:
	$CanvasLayer/AnimationPlayer.play("fade in")
	$CanvasLayer/TextureRect/AnimationPlayer.play("jumping")
	$CanvasLayer/Label.text = str(GameSettings.gems)
	
	if $CanvasLayer/AnimationPlayer.animation_finished.is_connected(_on_animation_finished):
		$CanvasLayer/AnimationPlayer.animation_finished.disconnect(_on_animation_finished)
	if $CanvasLayer/AnimationPlayer.animation_finished.is_connected(_on_animation1_finished):
		$CanvasLayer/AnimationPlayer.animation_finished.disconnect(_on_animation1_finished)
	if $CanvasLayer/AnimationPlayer.animation_finished.is_connected(change_scene_when_finished):
		$CanvasLayer/AnimationPlayer.animation_finished.disconnect(change_scene_when_finished)

	if GameSettings.user_id != null:
		$"CanvasLayer/sign in".visible = false
		$"CanvasLayer/sign in".disabled = true
		$CanvasLayer/store.visible = true
		$CanvasLayer/store2.visible = true
		$CanvasLayer/guns.visible = true
		$CanvasLayer/TextureRect2.visible = true
	else:
		$CanvasLayer/store.visible = false
		$CanvasLayer/store2.visible = false
		$CanvasLayer/guns.visible = false
		$CanvasLayer/TextureRect2.visible = false

func _on_play_pressed():
	$CanvasLayer/AudioStreamPlayer.play()
	$"CanvasLayer/play/play pressed".play("play pressed")
	print("Player is trying to play!")

func _on_settings_pressed():
	$CanvasLayer/AudioStreamPlayer.play()
	$"CanvasLayer/settings/settings pressed".play("settings pressed")
	$CanvasLayer/AnimationPlayer.play("fade out")
	
	$CanvasLayer/AnimationPlayer.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished(_anim_name: String):
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_store_pressed():
	$CanvasLayer/AudioStreamPlayer.play()
	$"CanvasLayer/store/store pressed".play("store pressed")
	$CanvasLayer/AnimationPlayer.play("fade out")
	$CanvasLayer/AnimationPlayer.animation_finished.connect(_on_animation1_finished, CONNECT_ONE_SHOT)

func _on_animation1_finished(_anim_name: String):
	get_tree().change_scene_to_file("res://scenes/character_store_3d.tscn")

func _on_guns_pressed() -> void:
	$"CanvasLayer/guns/store pressed".play("store pressed")
	$CanvasLayer/AudioStreamPlayer.play()
	$CanvasLayer/AnimationPlayer.play("fade out")
	$CanvasLayer/AnimationPlayer.animation_finished.connect(change_scene_when_finished, CONNECT_ONE_SHOT)

func change_scene_when_finished(_anim_name: StringName):
	get_tree().change_scene_to_file("res://scenes/weapon_store_3d.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sign_in.tscn")

func _on_touch_screen_button_pressed() -> void:
	OS.shell_open("https://khofyassershooterofficall.netlify.app/")
