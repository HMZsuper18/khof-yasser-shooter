extends Node3D


@onready var animation_player = $characters/character

func _ready() -> void:
	# هنروح على طول على GameSettings عشان نجيب اسم الشخصية
	var player_character_name = GameSettings.active_character
	var weapon_name = GameSettings.active_weapon
	
	if not player_character_name.is_empty():
		play_character_animation(player_character_name)
	else:
		print("فيه مشكلة: اسم الشخصية مش موجود.")
		
	# هنا هو التصليح
	if not weapon_name.is_empty():
		# هنستدعي الدالة اللي بتشغل انيميشن السلاح ونمرر ليها اسم السلاح
		play_weapon_animation(weapon_name)
	else:
		print("فيه مشكلة: اسم السلاح مش موجود.")


func play_character_animation(character_name):
	# دي الطريقة البدائية
	if character_name == "yasser":
		animation_player.play("yasser")
	elif character_name == "broasty_shan":
		animation_player.play("broasty")
	elif character_name == "3ammer":
		animation_player.play("3ammer")
	elif character_name == "legendary":
		animation_player.play("legenadary yasser")
	else:
		print("الشخصية المختارة غير معروفة، أو مفيش انيميشن ليها.")
		animation_player.stop()

# هنا برضه التصليح، الدالة بتاخد اسم السلاح كـ parameter
func play_weapon_animation(weapon_name):
	# تأكد ان المسار ده صحيح وموجود في المشهد
	var weapon_anim_player = $weapons/weapon
	
	if weapon_anim_player:
		if weapon_name == "ak47": # لاحظ "ak47" مش "ak-47"
			weapon_anim_player.play("ak-47")
		elif weapon_name == "pistol":
			weapon_anim_player.play("pistol")
		elif weapon_name == "vector":
			weapon_anim_player.play("vector")
		elif weapon_name == "shotgun":
			weapon_anim_player.play("shotgun")
		else:
			print("السلاح المختار غير معروف، أو مفيش انيميشن ليه.")
			weapon_anim_player.stop()
	else:
		print("لم يتم العثور على AnimationPlayer للسلاح.")
