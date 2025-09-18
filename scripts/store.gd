extends Control

const FIREBASE_PROJECT_ID = "khof-yasser-shooter-database"
var http_request = HTTPRequest.new()

# استدعاء الجلوبال سكريبت
@onready var GameSettings = get_node("/root/GameSettings")

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_completed)

func _on_ammer_gems_pressed() -> void:
	var skin_name = "3ammer"
	var skin_cost = 300
	
	if GameSettings.gems >= skin_cost:
		print("الرصيد كافٍ، جاري الشراء...")
		buy_and_equip_skin(skin_name, skin_cost)
	else:
		print("فشل ذريع: الرصيد غير كافٍ")

func buy_and_equip_skin(skin_name, skin_cost):
	# بننقص الفلوس محلياً أولاً
	GameSettings.gems -= skin_cost
	GameSettings.active_character = skin_name
	
	# بنعدل البيانات في Firebase عن طريق HTTPRequest
	var url = "https://firestore.googleapis.com/v1/projects/" + FIREBASE_PROJECT_ID + "/databases/(default)/documents/Users/" + GameSettings.user_id + "?updateMask.fieldPaths=gems,skins." + skin_name + ",active_skin"
	
	var data_to_update = {
		"fields": {
			"gems": {
				"integerValue": str(GameSettings.gems)
			},
			"skins": {
				"mapValue": {
					"fields": {
						skin_name: {
							"booleanValue": true
						}
					}
				}
			},
			"active_skin": {
				"stringValue": skin_name
			}
		}
	}
	
	var headers = [
		"Content-Type: application/json",
		"Accept: application/json"
	]
	
	var body = JSON.stringify(data_to_update)
	http_request.request(url, headers, HTTPClient.METHOD_PATCH, body)

func _on_http_request_completed(_result, response_code: int, _headers, body: PackedByteArray):
	if response_code == 200:
		print("تم تحديث البيانات بنجاح في Firebase.")
	else:
		var error_message = body.get_string_from_utf8()
		print("فشل تحديث البيانات في Firebase. الخطأ:", response_code, ", الرسالة:", error_message)
		# هنا ممكن تعمل rollback لو فيه خطأ، يعني ترجع الجواهر للاعب
		GameSettings.gems = GameSettings.gems + 300
		GameSettings.active_character = "" # أو أي قيمة ترجع ليها
#هاي جماعة الخير
