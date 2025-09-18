extends Control

@onready var my_label = $Label

func _ready() -> void:
	$AnimationPlayer.play("fade in")
	
	# نوصل بالإشارة اللي هتتبعت من الـ splash screen
	var splash_screen_node = get_tree().get_root().find_child("splash_screen", true)
	if splash_screen_node:
		splash_screen_node.player_data_loaded.connect(update_gems_display)
	else:
		# لو ملقيناش الـ splash screen، يبقى البيانات متحملة بالفعل
		update_gems_display()

func _on_play_pressed():
	$AudioStreamPlayer.play()
	$"play/play pressed".play("play pressed")
	print("Player is trying to play!")

func _on_settings_pressed():
	$AudioStreamPlayer.play()
	$"settings/settings pressed".play("settings pressed")
	$AudioStreamPlayer.finished.connect(_on_sound_finished)

func _on_sound_finished():
	$AnimationPlayer.play("fade out")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name: String):
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_store_pressed():
	$AudioStreamPlayer.play()
	$"store/store pressed".play("store pressed")
	$AudioStreamPlayer.finished.connect(_on_sound2_finished)

func _on_sound2_finished():
	$AnimationPlayer.play("fade out")
	$AnimationPlayer.animation_finished.connect(_on_animation2_finished)

func _on_animation2_finished(_anim_name: String):
	get_tree().change_scene_to_file("res://scenes/store.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sign_in.tscn")
	self.hide()
	$Button.disabled = true

func update_gems_display() -> void:
	my_label.text = str(GameSettings.gems)
