extends Control

const FIRESTORE_BASE_URL = "https://firestore.googleapis.com/v1/projects/khof-yasser-shooter-database/databases/(default)/documents"
const FIRESTORE_COLLECTION = "users" 
const API_KEY = "AIzaSyA4noTvXHgefHlf9M400WgeE0pf3E-ageM"

func _on_button_pressed() -> void:
	if GameSettings.gems >= 300:
		
		GameSettings.gems -= 300 
		print("✅ تم الشراء بنجاح! تم خصم 300 جوهرة. المتبقي: ", GameSettings.gems)
		
		var request_node = HTTPRequest.new()
		add_child(request_node)
		
		request_node.request_completed.connect(_on_firebase_request_completed.bind(request_node))
		
		# بناء الـ URL لـ Firestore: .../documents/users/{user_id}?key={API_KEY}
		var url = FIRESTORE_BASE_URL + "/" + FIRESTORE_COLLECTION + "/" + GameSettings.user_id + "?key=" + API_KEY
		
		# ***** التنسيق المعقد REQUIRED لـ Firestore *****
		var body_data = {
			"fields": {
				"active_character": {"stringValue": "3ammer"},
				# gems يجب أن تكون رقمًا. نستخدم str() لأن integerValue يتوقع نصًا للرقم.
				"gems": {"integerValue": str(GameSettings.gems)}, 
				"skins": {
					"mapValue": {
						"fields": {
							"3ammer": {"booleanValue": true}
						}
					}
				}
			}
		}
		var body = JSON.stringify(body_data)
		# **************************************************
		
		print("🔍 بيانات الـ JSON المرسلة:", body)

		var error = request_node.request(
			url, 
			["Content-Type: application/json"], 
			HTTPClient.METHOD_PATCH, 
			body
		)
		
		if error != OK:
			push_error("❌ فشل في إرسال طلب Firestore: ", error)
			GameSettings.gems += 300
			request_node.queue_free()
		else:
			print("🌐 تم إرسال طلب التحديث بنجاح إلى Firestore.")
			
	else:
		print("❌ لا يوجد جواهر كافية. مطلوب 300 أو أكثر، لديك: ", GameSettings.gems)

func _on_firebase_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray, request_node: HTTPRequest):
	
	if response_code == 200: 
		print("✅ تم تحديث Cloud Firestore بنجاح!")
		
	else:
		push_error("⚠️ فشل تحديث Firestore. كود الرد: ", response_code)
		push_error("⚠️ نص الرد من Firestore:", body.get_string_from_utf8())
		GameSettings.gems += 300
		print("❌ تمت استعادة 300 جوهرة بسبب فشل التحديث.")

	request_node.queue_free()

func _on__pressed() -> void:
	if GameSettings.gems >= 500:
		print("✅ الشرط تحقق! قيمة الجواهر هي: ", GameSettings.gems)       
	else:
		print("❌ لا يوجد جواهر كافية. مطلوب 500 أو أكثر، لديك: ", GameSettings.gems)

func _on_الحياة_pressed() -> void:
	if GameSettings.gems >= 1000:
		print("✅ الشرط تحقق! قيمة الجواهر هي: ", GameSettings.gems)       
	else:
		print("❌ لا يوجد جواهر كافية. مطلوب 1000 أو أكثر، لديك: ", GameSettings.gems)
