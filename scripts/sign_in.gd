extends Control


const FIREBASE_API_KEY = "AIzaSyA4noTvXHgefHlf9M400WgeE0pf3E-ageM"
const FIREBASE_SIGNIN_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
const FIREBASE_SIGNUP_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
const FIRESTORE_URL = "https://firestore.googleapis.com/v1/projects/khof-yasser-shooter-database/databases/(default)/documents/Users"
const FIREBASE_AUTH_DOMAIN = "khof-yasser-shooter-database.firebaseapp.com"


var eight_digit_number: int = randi_range(10000000, 99999999)
var http_request = HTTPRequest.new()
var is_signing_up = false
var user_id = ""
var user_token = ""


func _ready():
	$Panel/password.secret = true
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

func _on_sign_in_pressed() -> void:
	var email = $Panel/email.text
	var password = $Panel/password.text
	var player_name = $"Panel/name enter".text
	
	if email.is_empty() or password.is_empty() or player_name.is_empty():
		return

	is_signing_up = false

	var auth_url = FIREBASE_SIGNIN_URL + FIREBASE_API_KEY
	
	var request_body = {
		"email": email,
		"password": password,
		"returnSecureToken": true
	}

	var headers = ["Content-Type: application/json"]
	var body_json = JSON.stringify(request_body)
	http_request.request(auth_url, headers, HTTPClient.METHOD_POST, body_json)

func _on_request_completed(_result, response_code: int, _headers, body: PackedByteArray) -> void:
	var response_body = body.get_string_from_utf8()
	var json_data = JSON.parse_string(response_body)

	if response_code == 200:
		if "idToken" in json_data and "localId" in json_data:
			user_id = eight_digit_number
			user_token = json_data.idToken
			
			print("1. User ID from Firebase auth: ", user_id)
			
			GameSettings.user_id = user_id
			
			if is_signing_up:
				create_user_document()
			else:
				get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
		else:
			print("فيه مشكلة في تسجيل الدخول أو إنشاء الحساب. كود الخطأ:", response_code)
	else:
		print("الرد الخام من Firebase: ", response_body)
		if "error" in json_data:
			if (json_data.error.message == "EMAIL_NOT_FOUND" or json_data.error.message == "INVALID_LOGIN_CREDENTIALS") and not is_signing_up:
				is_signing_up = true
				_on_sign_up_pressed()
			else:
				print("خطأ في تسجيل الدخول: ", json_data.error.message)
				print("حالة تسجيل الدخول: غير صحيح!")

func _on_sign_up_pressed() -> void:
	var email = $Panel/email.text
	var password = $Panel/password.text
	var player_name = $"Panel/name enter".text # تم تغيير "name" إلى "player_name"
	
	if email.is_empty() or password.is_empty() or player_name.is_empty(): # استخدام "player_name"
		print("الرجاء إدخال الإيميل وكلمة المرور والاسم.")
		return
	
	print("جاري إنشاء الحساب...")

	var auth_url = FIREBASE_SIGNUP_URL + FIREBASE_API_KEY
	
	var request_body = {
		"email": email,
		"password": password,
		"returnSecureToken": true
	}

	var headers = ["Content-Type: application/json"]
	var body_json = JSON.stringify(request_body)
	http_request.request(auth_url, headers, HTTPClient.METHOD_POST, body_json)

func _on_button_button_down() -> void:
	$Panel/password.secret = false
	

func _on_button_button_up() -> void:
	$Panel/password.secret = true


func create_user_document():
	print("الآن جاري إنشاء Document للمستخدم: ", user_id)
	
	var firestore_request = HTTPRequest.new()
	add_child(firestore_request)
	
	var headers = ["Content-Type: application/json"]
	
	var name_from_line_edit = $"Panel/name enter".text # تأكد إن ده نفس اسم الـLineEdit اللي في المشهد
	
	var initial_data = {
		"fields": {
			"level": {"integerValue": "1"},
			"name": {"stringValue": name_from_line_edit},
		}
	}
	
	var body_json = JSON.stringify(initial_data)
	
	var firestore_url_with_id = FIRESTORE_URL + "?documentId=" + str(user_id)
	
	firestore_request.request(firestore_url_with_id, headers, HTTPClient.METHOD_POST, body_json)
	
	firestore_request.request_completed.connect(func(_result, _response_code, _headers, _body):
		firestore_request.queue_free()
		if _response_code == 200:
			print("تم إنشاء Document للمستخدم بنجاح!")
			get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
		else:
			print("فشل إنشاء Document للمستخدم!")
)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/3d_lobby.tscn")
