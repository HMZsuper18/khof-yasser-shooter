extends Control


const FIREBASE_PROJECT_ID = "khof-yasser-shooter-database"
var http_request = HTTPRequest.new()

var is_animation_finished = false
var is_data_loaded = false


func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_completed)

	var animation_player = $AnimationPlayer
	if animation_player:
		animation_player.play("splash screen")
		animation_player.animation_finished.connect(_on_animation_finished)
	else:
		is_animation_finished = true
		check_and_transition()
	
	if GameSettings.user_id.is_empty():
		get_tree().change_scene_to_file("res://scenes/sign_in.tscn")
	else:
		load_player_data_from_firebase()


func _on_animation_finished(_anim_name: String):
	is_animation_finished = true
	check_and_transition()


func load_player_data_from_firebase():
	var url = "https://firestore.googleapis.com/v1/projects/" + FIREBASE_PROJECT_ID + "/databases/(default)/documents/Users/" + GameSettings.user_id
	http_request.request(url)


func _on_http_request_completed(_result, response_code: int, _headers, body: PackedByteArray):
	if response_code == 200:
		var response_body = body.get_string_from_utf8()
		var json_data = JSON.parse_string(response_body)
		
		if json_data and "fields" in json_data:
			if "active_character" in json_data.fields:
				GameSettings.active_character = json_data.fields.active_character.stringValue
			if "active_weapon" in json_data.fields:
				GameSettings.active_weapon = json_data.fields.active_weapon.stringValue
			
			# ده التعديل النهائي: دلوقتي بنقرأ قيمة الجواهر كـ "integerValue"
			if "gems" in json_data.fields:
				GameSettings.gems = int(json_data.fields.gems.integerValue)
			
			if "skins" in json_data.fields:
				GameSettings.owned_characters = json_data.fields.skins.mapValue.fields
			if "weapons" in json_data.fields:
				GameSettings.owned_weapons = json_data.fields.weapons.mapValue.fields
			
			is_data_loaded = true
			check_and_transition()
		else:
			print("فشل العثور على البيانات الأساسية.")
			get_tree().change_scene_to_file("res://scenes/sign_in.tscn")
	else:
		print("فشل تحميل بيانات اللاعب من Firebase. خطأ:", response_code)
		get_tree().change_scene_to_file("res://scenes/sign_in.tscn")


func check_and_transition():
	if is_animation_finished and is_data_loaded:
		get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
