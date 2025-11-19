extends Control

var t = Vector2(0,0)
var s = Vector2(0,0)


func _ready():
	t = $PanelContainer.position
	s = $PanelContainer.size
	$TextureRect/AnimationPlayer.play("jumping")

func _process(_delta: float) -> void:
	if $PanelContainer:
		$PanelContainer.position = $PanelContainer.position.lerp(t, 0.15)
		$PanelContainer.size = $PanelContainer.size.lerp(s, 0.15)
	$Label.text = str(int(GameSettings.gems))

	if "3ammer" != GameSettings.active_character and "3ammer" in GameSettings.owned_characters:
		$"Control/3ammer".icon = load("res://images/select.png")
		$Control/Label.text = "select"
	elif "3ammer" not in GameSettings.owned_characters:
		$"Control/3ammer".icon = load("res://images/payment.png")
		$Control/Label.text = "300"
	else:
		$"Control/3ammer".icon = load("res://images/select.png")
		$Control/Label.add_theme_font_size_override("font_size", 60)
		$Control/Label.text = "selected"
		t = Vector2(483,273)
		s = Vector2(181,151)

	if "broasty" != GameSettings.active_character and "broasty" in GameSettings.owned_characters:
		$"Control2/broasty".icon = load("res://images/select.png")
		$Control2/Label.text = "select"
	elif "broasty" not in GameSettings.owned_characters:
		$"Control2/broasty".icon = load("res://images/payment.png")
		$Control2/Label.text = "500"
	else:
		$Control2/broasty.icon = load("res://images/select.png")
		$Control2/Label.add_theme_font_size_override("font_size", 60)
		$Control2/Label.text = "selected"
		t = Vector2(701, 273)
		s = Vector2(181,151)

	if "legend" != GameSettings.active_character and "legendary" in GameSettings.owned_characters:
		$Control3/legendary.icon = load("res://images/select.png")
		$Control3/Label.text = "select"
	elif "legendary" not in GameSettings.owned_characters:
		$Control3/legendary.icon = load("res://images/payment.png")
		$Control3/Label.text = "1000"
	else:
		$Control3/legendary.icon = load("res://images/select.png")
		$Control3/Label.add_theme_font_size_override("font_size", 60)
		$Control3/Label.text = "selected"
		t = Vector2(480, 16)
		s = Vector2(181,190)

	if "yasser" != GameSettings.active_character:
		$Control4/Label.text = "select"
	else:
		$Control4/Label.text = "selected"
		t = Vector2(257, 235)
		s = Vector2(181,190)

func _on_ammer_pressed() -> void:
	if "3ammer" not in GameSettings.owned_characters:
		if GameSettings.gems >= 300:
			GameSettings.owned_characters.append("3ammer")
			GameSettings.active_character = "3ammer"
			GameSettings.gems -= 300
			$"Control/3ammer".icon = load("res://images/select.png")
			$Control/Label.add_theme_font_size_override("font_size", 60)
			$Control/Label.text = "Selcted"
			t = Vector2(483,273)
			s = Vector2(181,151)
	else:
		GameSettings.active_character = "3ammer"
		$Control/Label.text = "selcted"
		t = Vector2(483,273)
		s = Vector2(181,151)

func _on_broasty_pressed() -> void:
	if "broasty" not in GameSettings.owned_characters:
		if GameSettings.gems >= 500:
			GameSettings.owned_characters.append("broasty")
			GameSettings.active_character = "broasty"
			GameSettings.gems -= 500
			$"Control2/broasty".icon = load("res://images/select.png")
			$Control2/Label.add_theme_font_size_override("font_size", 60)
			$Control2/Label.text = "selected"
			t = Vector2(701, 273)
			s = Vector2(181,151)
	else:
		GameSettings.active_character = "broasty"
		$Control2/Label.text = "selcted"
		t = Vector2(701, 273)
		s = Vector2(181,151)

func _on_yasser_pressed() -> void:
	GameSettings.active_character = "yasser"
	$Control4/Label.add_theme_font_size_override("font_size", 60)
	$Control4/Label.text = "selected"
	t = Vector2(257, 235)
	s = Vector2(181,190)

func _on_legendary_pressed() -> void:
	if "legendary" not in GameSettings.owned_characters:
		if GameSettings.gems >= 500:
			GameSettings.owned_characters.append("legendary")
			GameSettings.active_character = "legend"
			GameSettings.gems -= 500
			$"Control3/legendary".icon = load("res://images/select.png")
			$Control3/Label.add_theme_font_size_override("font_size", 60)
			$Control3/Label.text = "selected"
			t = Vector2(480, 16)
			s = Vector2(181,190)
	else:
		GameSettings.active_character = "legend"
		$"Control3/legendary".icon = load("res://images/select.png")
		$Control3/Label.text = "selcted"
		t = Vector2(480, 16)
		s = Vector2(181,190)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
