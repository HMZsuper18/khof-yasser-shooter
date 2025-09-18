extends Node


var save_path = "user://game_settings.json"
var user_id = ""
var active_character = "" 
var active_weapon = "" 
var owned_characters = {} 
var owned_weapons = {} 
var gems = 0

var settings_data = {
	"volume_db": 0.0,
	"user_id": ""
}


func _ready():
	load_settings()


func save_settings():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		settings_data.user_id = user_id
		settings_data.gems = gems
		settings_data.owned_characters = owned_characters
		settings_data.owned_weapons = owned_weapons
		
		file.store_string(JSON.stringify(settings_data))
		file.close()


func load_settings():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			var parsed_data = JSON.parse_string(content)
			
			if typeof(parsed_data) == TYPE_DICTIONARY:
				settings_data = parsed_data
				if "user_id" in settings_data:
					user_id = settings_data.user_id
				if "gems" in settings_data:
					gems = settings_data.gems
				if "owned_characters" in settings_data:
					owned_characters = settings_data.owned_characters
				if "owned_weapons" in settings_data:
					owned_weapons = settings_data.owned_weapons
			
			file.close()
