extends Control

@export var volume_slider: HSlider
@export var brightness_slider: HSlider

func _ready() -> void:
	if volume_slider:
		volume_slider.value_changed.connect(_on_h_slider_value_changed)
		var saved_volume_db = GameSettings.settings_data["volume_db"]
		var saved_volume_value = db_to_linear(saved_volume_db) * 100
		volume_slider.value = saved_volume_value
	
	if brightness_slider:
		brightness_slider.value_changed.connect(_on_brightness_slider_value_changed)
		brightness_slider.value = GameSettings.settings_data["brightness"]
	
	$AnimationPlayer.play("fade in")

func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade out")
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect(_on_sound_finished)

func _on_sound_finished():
	get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")

func _on_h_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value / 100.0)
	GameSettings.settings_data["volume_db"] = db
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
	GameSettings.save_settings()

func _on_brightness_slider_value_changed(value: float) -> void:
	GameSettings.settings_data["brightness"] = value
	GameSettings.set_brightness(value) # هنا بنستدعي الدالة من الـSingleton
	GameSettings.save_settings()
