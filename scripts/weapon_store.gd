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

	if "ak47" != GameSettings.active_weapon and "ak47" in GameSettings.owned_weapons:
		$ak47/ak47.icon = load("res://images/select.png")
		$ak47/Label.text = "select"
	elif "ak47" not in GameSettings.owned_weapons:
		$ak47/ak47.icon = load("res://images/payment.png")
		$ak47/Label.text = "500"
	else:
		$ak47/ak47.icon = load("res://images/select.png")
		$ak47/Label.add_theme_font_size_override("font_size", 60)
		$ak47/Label.text = "selected"
		t = Vector2(483,273)
		s = Vector2(181,151)

	if "victor" != GameSettings.active_weapon and "victor" in GameSettings.owned_weapons:
		$auto/victor.icon = load("res://images/select.png")
		$auto/Label.text = "select"
	elif "victor" not in GameSettings.owned_weapons:
		$auto/victor.icon = load("res://images/payment.png")
		$auto/Label.text = "750"
	else:
		$auto/victor.icon = load("res://images/select.png")
		$auto/Label.add_theme_font_size_override("font_size", 60)
		$auto/Label.text = "selected"
		t = Vector2(701, 273)
		s = Vector2(181,151)

	if "shotgun" != GameSettings.active_weapon and "shotgun" in GameSettings.owned_weapons:
		$shotgun/shotgun.icon = load("res://images/select.png")
		$shotgun/Label.text = "select"
	elif "shotgun" not in GameSettings.owned_weapons:
		$shotgun/shotgun.icon = load("res://images/payment.png")
		$shotgun/Label.text = "1000"
	else:
		$shotgun/shotgun.icon = load("res://images/select.png")
		$shotgun/Label.add_theme_font_size_override("font_size", 60)
		$shotgun/Label.text = "selected"
		t = Vector2(480, 16)
		s = Vector2(181,190)

	if "pistol" != GameSettings.active_weapon:
		$pistol/Label.text = "select"
	else:
		$pistol/Label.text = "selected"
		t = Vector2(257, 235)
		s = Vector2(181,190)

func _on_ak_47_pressed() -> void:
	if "ak47" not in GameSettings.owned_weapons:
		if GameSettings.gems >= 500:
			GameSettings.owned_weapons.append("ak47")
			GameSettings.active_weapon = "ak47"
			GameSettings.gems -= 500
			$ak47/ak47.icon = load("res://images/select.png")
			$ak47/Label.add_theme_font_size_override("font_size", 60)
			$ak47/Label.text = "Selcted"
			t = Vector2(483,273)
			s = Vector2(181,151)
	else:
		GameSettings.active_weapon = "ak47"
		$ak47/Label.text = "selcted"
		t = Vector2(483,273)
		s = Vector2(181,151)

func _on_victor_pressed() -> void:
	if "victor" not in GameSettings.owned_weapons:
		if GameSettings.gems >= 750:
			GameSettings.owned_weapons.append("victor")
			GameSettings.active_weapon = "victor"
			GameSettings.gems -= 750
			$auto/victor.icon = load("res://images/select.png")
			$auto/Label.add_theme_font_size_override("font_size", 60)
			$auto/Label.text = "selected"
			t = Vector2(701, 273)
			s = Vector2(181,151)
	else:
		GameSettings.active_weapon = "victor"
		$auto/Label.text = "selcted"
		t = Vector2(701, 273)
		s = Vector2(181,151)

func _on_pistol_pressed() -> void:
	GameSettings.active_weapon = "pistol"
	$pistol/Label.add_theme_font_size_override("font_size", 60)
	$pistol/Label.text = "selected"
	t = Vector2(257, 235)
	s = Vector2(181,190)

func _on_shotgun_pressed() -> void:
	if "shotgun" not in GameSettings.owned_weapons:
		if GameSettings.gems >= 1200:
			GameSettings.owned_weapons.append("shotgun")
			GameSettings.active_weapon = "shotgun"
			GameSettings.gems -= 1200
			$shotgun/shotgun.icon = load("res://images/select.png")
			$shotgun/Label.add_theme_font_size_override("font_size", 60)
			$shotgun/Label.text = "selected"
			t = Vector2(480, 16)
			s = Vector2(181,190)
	else:
		GameSettings.active_weapon = "shotgun"
		$shotgun/shotgun.icon = load("res://images/select.png")
		$shotgun/Label.text = "selcted"
		t = Vector2(480, 16)
		s = Vector2(181,190)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
