extends KinematicBody2D 

onready var mesh = $MeshInstance2D
onready var type7 = preload("res://Type7.tscn")
onready var timez = get_node("timez")
onready var timez2 = get_node("timez2")
var paper = false
var crab = 0
var motion = Vector2()
var speed = 350
var spider_count = 0
var scorpion_count = 0
var horse_count = 0
var golem_count = 0
var golem2_count = 0
var golem3_count = 0
var bot_count = 0
var death_time = 2
var collision_count = 0
var talked_sam = false
var talked_john = false
var is_talking = false
var talked = false
var dead = false
var sad = false
var map = false
var bear = 0
onready var  speechmanager = get_node("../Speechmanager")
var swoosh = preload("res://SCENE/fire.tscn")
var icy = preload("res://SCENE/ice.tscn")
signal chicken_launched
signal chicken_preso
signal moves_pos
signal check


func _ready():
	colonnetta()
	GlobalLabel.timer_on = true
	Jason.Dict["weaponhave"] = 3
	if Jason.Dict["intro"] ==0:
		set_process(false)
		Jason.Dict["intro"] =1
		$Pug.play("sit up")
		$Pug2.play("sit up")
		timez.start(1)
		yield(timez, "timeout")
		speechmanager.initial()
	elif Jason.Dict["intro"] !=0:
		$Camera2D.zoom.x = 1.3
		$Camera2D.zoom.y = 1.3
	
		
	
func _on_Arthur_tree_entered():
	if Jason.Dict["saved"] == 1:
		self.position =  Vector2(-11696.792, -2462.364)
	elif Jason.Dict["saved"] == 2:
		self.position =  Vector2(3577.4, -6337.755)
	elif Jason.Dict["saved"] == 3:
		self.position =  Vector2(19157.293, -5509.017)
	elif Jason.Dict["saved"] == 4:
		self.position =  Vector2(-22695, -4140)
	elif Jason.Dict["saved"] == 5:
		self.position =  Vector2(21650, -7440)
	else: 
		#self.position = Vector2(-455, 278)
		self.position = Vector2(-2395.84, 4235.741)
		Jason.Dict["chicken_count"] = 0

func _physics_process(_delta):
	pass

	
	
	

	
	

func _process(delta):
	var velocity = Vector2()
	#$Camera2D.global_position = lerp($Camera2D.global_position, self.global_position, delta * 600 )
	var fps = Engine.get_frames_per_second()
	var lerp_interval = velocity / fps
	var lerp_position = global_transform.origin + lerp_interval
	if fps >60:
		mesh.set_as_toplevel(true)
		mesh.global_transform.origin = mesh.global_transform.origin.linear_interpolate(lerp_position, 10*delta)
	else:
		mesh.global_transform = global_transform
		mesh.set_as_toplevel(false)

	if  $chickenThrowCooldown.time_left ==0 and Input.is_key_pressed(KEY_E) and Jason.Dict["weapon"] ==1:
		$chickenThrowCooldown.start()
		launch_chicken()
	
	if  $chickenThrowCooldown.time_left ==0 and Input.is_action_just_pressed("shoot") and Jason.Dict["weapon"] ==1:
		$chickenThrowCooldown.start()
		launch_chicken()
	
	elif $chickenThrowCooldown.time_left ==0 and Input.is_key_pressed(KEY_E) and Jason.Dict["weapon"] ==2:
		$chickenThrowCooldown.start()
		launch_fire()
		
	elif $chickenThrowCooldown.time_left ==0 and Input.is_action_just_pressed("shoot")  and Jason.Dict["weapon"] ==2:
		$chickenThrowCooldown.start()
		launch_fire()
		
		
	elif $chickenThrowCooldown.time_left ==0 and Input.is_key_pressed(KEY_E) and Jason.Dict["weapon"] ==3:
		$chickenThrowCooldown.start()
		launch_ice()
	
	elif $chickenThrowCooldown.time_left ==0 and  Input.is_action_just_pressed("shoot")  and Jason.Dict["weapon"] ==3:
		$chickenThrowCooldown.start()
		launch_ice()
	
		
	
	#var velocity = Vector2()
	if Input.is_key_pressed(KEY_UP) or Input.is_action_pressed("uppad"):
		velocity.y = -1
		$Arthur.call_deferred("set", "disabled", false)
		$Arthur2.call_deferred("set", "disabled", true)
		$RayCast2D.cast_to =Vector2(0, -75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(0, -100)
		emit_signal("moves_pos")
		#Jason.save_game()
	
	if Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_LEFT) or Input.is_action_pressed("uppad") and Input.is_action_pressed("leftpad"):
		velocity.y = -0.5
		velocity.x = -0.5
		$RayCast2D.cast_to =Vector2(-75, -75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(-100, -100)
		emit_signal("moves_pos")
		
		
		
		
	elif Input.is_key_pressed(KEY_DOWN) and Input.is_key_pressed(KEY_LEFT) or Input.is_action_pressed("downpad") and Input.is_action_pressed("leftpad"):
		velocity.y = 0.5
		velocity.x = -0.5
		$RayCast2D.cast_to =Vector2(-75, 75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(-100, 100)
		emit_signal("moves_pos")
		
	elif Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_RIGHT) or Input.is_action_pressed("uppad") and Input.is_action_pressed("rightpad"):
		velocity.y = -0.5
		velocity.x = 0.5
		$RayCast2D.cast_to =Vector2(75, -75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(100, -100)
		emit_signal("moves_pos")
		
	elif Input.is_key_pressed(KEY_DOWN) and Input.is_key_pressed(KEY_RIGHT) or Input.is_action_pressed("downpad") and Input.is_action_pressed("rightpad") :
		velocity.y = 0.5
		velocity.x = 0.5
		$RayCast2D.cast_to =Vector2(75, 75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(100, 100)
		emit_signal("moves_pos")
	
	elif Input.is_key_pressed(KEY_DOWN)  or Input.is_action_pressed("downpad"):
		$Arthur.call_deferred("set", "disabled", false)
		$Arthur2.call_deferred("set", "disabled", true)
		velocity.y = 1
		$RayCast2D.cast_to =Vector2(0, 75)
		Jason.Dict["main_position"] = $".".global_position + Vector2(0, 100)
		emit_signal("moves_pos")
		#Jason.save_game()
	elif Input.is_key_pressed(KEY_LEFT)  or Input.is_action_pressed("leftpad"):
		$Arthur.call_deferred("set", "disabled", true)
		$Arthur2.call_deferred("set", "disabled", false)
		velocity.x = -1
		$RayCast2D.cast_to =Vector2(-75, 0)
		Jason.Dict["main_position"] = $".".global_position + Vector2(-100, 0)
		Jason.Dict["check_position"] = $".".global_position + Vector2(-100, 0)
		emit_signal("moves_pos")
		#Jason.save_game()
	elif Input.is_key_pressed(KEY_RIGHT)  or Input.is_action_pressed("rightpad"):
		$Arthur.call_deferred("set", "disabled", true)
		$Arthur2.call_deferred("set", "disabled", false)
		velocity.x = 1
		$RayCast2D.cast_to =Vector2(75, 0)
		Jason.Dict["main_position"] = $".".global_position + Vector2(100, 0)
		Jason.Dict["check_position"] = $".".global_position + Vector2(100, 0)
		emit_signal("moves_pos")
		#Jason.save_game()
	var speed = 350
	var movement = speed *velocity.normalized()*delta
# warning-ignore:return_value_discarded
	self.move_and_collide(movement)
	self.update_animation(velocity)
	if $RayCast2D.is_colliding():
# warning-ignore:unused_variable
		var collider = $RayCast2D.get_collider()
	
	
	

	#	var dialog = Dialogic.start("chat")
		
		#riga per prendere il pollo
		
		
	var collider = $RayCast2D.get_collider()
	if collider != null  and "chicken" in collider.name: #and Input.is_key_pressed(KEY_SPACE)
		collider.queue_free()
		Jason.Dict["chicken_count"] += 1
		Jason.save_game()
		emit_signal("chicken_preso" , Jason.Dict["chicken_count"])
		#$fart.play()
		
		
		
		
	if collider != null and Input.is_key_pressed(KEY_SPACE) and "spada" in collider.name:
		collider.queue_free()
		Jason.Dict["spada_count"] += 1
		#Savefile.save_game()
		emit_signal("spada_preso" , Jason.Dict["spada_count"])
		
			
		#riga per prendere la spada


		

	
	if collider != null and "robot" in collider.name and timez.is_stopped():
		timez.start(0.5)
		MusicManager.arthur18()
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*1
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
		
	

	if Jason.Dict["health"] != 100:
		health()
		check_health()
		
	
	

		
	
	if collider != null and "areag"  in collider.name  and timez.time_left == 0 and golem_count == 0:
		timez.start(0.2)
		yield(timez, "timeout")
		golem_count = 1
		add_golem()
		$"../areag".queue_free()
	if collider != null and "areaf"  in collider.name  and timez.time_left == 0 and golem2_count == 0:
		timez.start(0.2)
		yield(timez, "timeout")
		golem2_count = 1
		add_golem2()
		$"../areaf".queue_free()
	if collider != null and "areah"  in collider.name  and timez.time_left == 0 and golem3_count == 0:
		timez.start(0.2)
		yield(timez, "timeout")
		golem3_count = 1
		add_golem3()
		timez.start(2)
		yield(timez, "timeout")
		golem3_count = 0
		$"../areah".queue_free()
		
	
	if collider != null and "AreaWest" in collider.name:
		colonnetta()
		emit_signal("check")
		Jason.Dict["ever_saved"] = 1
		if Jason.Dict["saved"] != 1:
			Jason.Dict["saved"] = 1
			MusicManager.flame()
		Jason.Dict["save_pos"] = Vector2(-11696.792, -2462.364)
		Jason.save_game()
	
	if collider != null and "AreaEast" in collider.name:
		colonnetta()
		emit_signal("check")
		Jason.Dict["ever_saved"] = 1
		if Jason.Dict["saved"] != 2:
			Jason.Dict["saved"] = 2
			MusicManager.flame()
		Jason.Dict["save_pos"] = Vector2(3577.4, -6337.755)
		Jason.save_game()
	
	if collider != null and "AreaNE" in collider.name:
		colonnetta()
		emit_signal("check")
		Jason.Dict["ever_saved"] = 1
		if Jason.Dict["saved"] != 3:
			Jason.Dict["saved"] = 3
			MusicManager.flame()
		Jason.Dict["save_pos"] = Vector2(19157.293, -5509.017)
		Jason.save_game()

		
	
	
		
	if Input.is_key_pressed(KEY_T) and Jason.Dict["map"] ==1:
		timez.start(0.1)
		yield(timez,"timeout")
		$"../UI_MAIN/mapfinal".show()
		Jason.Dict["map"] =2
		
	
	if  Input.is_key_pressed(KEY_T) and Jason.Dict["map"] ==2:
		timez.start(0.1)
		yield(timez,"timeout")
		$"../UI_MAIN/mapfinal".hide()
		Jason.Dict["map"] =1
		
	#JOYPAD
		
	
		

#Animazione e movimenti Arthur
func update_animation(velocity):
	if velocity.y == -1:
		$Pug.play("up")
		$Pug2.play("up")
	elif velocity.x == +1:
		$Pug.play("right")
		$Pug2.play("right")
	elif velocity.x == -1:
		$Pug.play("left")
		$Pug2.play("left")
	elif velocity.y == +1:
		$Pug.play("down")
		$Pug2.play("down")
	elif velocity.x == -0.5 and velocity.y == -0.5:
		$Pug.play("DUL")
		$Pug2.play("DUL")
		#KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") and Input.is_action_just_released("ui_left") :
		$Pug.play("DSUL")
		$Pug2.play("DSUL")
		#JOYPAD
	elif velocity == Vector2() and Input.is_action_just_released("uppad") and Input.is_action_just_released("leftpad") :
		$Pug.play("DSUL")
		$Pug2.play("DSUL")
		#KEYBOARD
	elif velocity.x == -0.5 and velocity.y == 0.5:
		$Pug.play("DDL")
		$Pug2.play("DDL")
		#KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") and Input.is_action_just_released("ui_left"):
		#print(get_floor_angle())
		$Pug.play("DSDL")
		$Pug2.play("DSDL")
		#JOYPAD
	elif velocity == Vector2() and Input.is_action_just_released("downpad") and Input.is_action_just_released("leftpad"):
		$Pug.play("DSDL")
		$Pug2.play("DSDL")
		#KEYBOARD
	elif velocity.y == -0.5 and velocity.x == 0.5:
		$Pug.play("DUR")
		$Pug2.play("DUR")
		#KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") and Input.is_action_just_released("ui_right"):
		$Pug.play("DSUR")
		$Pug2.play("DSUR")
		#JOYPAD
	elif velocity == Vector2() and Input.is_action_just_released("uppad") and Input.is_action_just_released("rightpad"):
		$Pug.play("DSUR")
		$Pug2.play("DSUR")
		#KEYBOARD
	elif velocity.y == 0.5 and velocity.x == 0.5:
		$Pug.play("DDR")
		$Pug2.play("DDR")
		#KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") and Input.is_action_just_released("ui_right"):
		$Pug.play("DSDR")
		$Pug2.play("DSDR")
		#JOYPAD
	elif velocity == Vector2() and Input.is_action_just_released("downpad") and Input.is_action_just_released("rightpad"):
		$Pug.play("DSDR")
		$Pug2.play("DSDR")
		#JOYPAD + KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") or Input.is_action_just_released("downpad"):
		$Pug.play("sit front")
		$Pug2.play("sit front")
		#JOYPAD + KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_right") or Input.is_action_just_released("rightpad"):
		$Pug.play("sit right")
		$Pug2.play("sit right")
		#JOYPAD + KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_left") or Input.is_action_just_released("leftpad"):
		$Pug.play("sit left")
		$Pug2.play("sit left")
		#JOYPAD + KEYBOARD
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") or Input.is_action_just_released("uppad"):
		$Pug.play("sit up")
		$Pug2.play("sit up")

func colonnetta():
	if Jason.Dict["saved"] ==1:
		$"../colonnetta/Colonnetta/fuocoz".play("fuocoz")
		$"../colonnetta2/Colonnetta2/fuocoz2".play("deafault")
		$"../colonnetta3/Colonnetta3/fuocoz3".play("deafault")
	elif Jason.Dict["saved"] ==2:
		$"../colonnetta/Colonnetta/fuocoz".play("deafault")
		$"../colonnetta2/Colonnetta2/fuocoz2".play("fuocoz")
		$"../colonnetta3/Colonnetta3/fuocoz3".play("deafault")
	elif Jason.Dict["saved"]  ==3:
		$"../colonnetta/Colonnetta/fuocoz".play("deafault")
		$"../colonnetta2/Colonnetta2/fuocoz2".play("deafault")
		$"../colonnetta3/Colonnetta3/fuocoz3".play("fuocoz")
		
func launch_chicken():
	var chicken_scene = load("res://SCENE/chicken scene.tscn")
	var chicken_node = chicken_scene.instance()
	chicken_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	chicken_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*1300)
	chicken_node.set_angular_velocity(200)
	get_node("/root/Game").add_child(chicken_node)
func launch_fire():
	var fire_scene = load("res://SCENE/fire.tscn")
	var fire_node = fire_scene.instance()
	fire_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	fire_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*2000)
	fire_node.set_angular_velocity(70)
	get_node("/root/Game").add_child(fire_node)
	MusicManager.swoosh()
func launch_ice():
	var ice_scene = load("res://SCENE/ice.tscn")
	var ice_node = ice_scene.instance()
	ice_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	ice_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*2000)
	ice_node.set_angular_velocity(400)
	get_node("/root/Game").add_child(ice_node)
	MusicManager.icy_spell()


func lessen_enemy():
	Jason.Dict["enemy_count"] -=1


func die():
	if Jason.Dict["saved"] != 0:
		timez2.start(4)
		var respawn_scene = load("res://respawn.tscn")
		var respawn_node = respawn_scene.instance()
		var respawn_scene2 = load("res://respawn2.tscn")
		var respawn_node2 = respawn_scene2.instance()
		set_process(false)
		$Pug.play("death left")
		$Pug2.play("death left")
		MusicManager.death()
		yield(timez2, "timeout")
		Jason.Dict["coll"] =0
		$Pug.hide()
		$Pug2.hide()
		get_node("/root/Game").add_child(respawn_node)
		respawn_node.position = self.position
		timez2.start(2)
		yield(timez2, "timeout")
		checkpoint()
		get_node("/root/Game").add_child(respawn_node2)
		set_process(true)
		timez2.start(0.7)
		Jason.Dict["health"] = 100
		$"../UI_MAIN/Healthz".value =100
		yield(timez2, "timeout")
		$Pug.show()
		$Pug2.show()
		$Pug.play("stand")
		$Pug2.play("stand")
		MusicManager.background()
	else:
		timez2.start(7)
		set_process(false)
		$Pug.play("death left")
		$Pug2.play("death left")
		MusicManager.death()
		$"CanvasLayer2/Label GO/scroll".play("appear")
		yield(timez2, "timeout")
		GlobalLabel.timer_on = false
		Jason.Dict["coll"] =0
		Jason.Dict["health"] = 100
		$"../UI_MAIN/Healthz".value =100
		$"..".queue_free()
		
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Type7.tscn")
		#MusicManager.none()
		DD.talked = false
		DD.talked_tobear = false
		DD.thought = false
	
	
func checkpoint():
	if Jason.Dict["saved"] == 1:
		self.position =  Vector2(-11696.792, -2462.364)
	elif Jason.Dict["saved"] == 2:
		self.position =  Vector2(3577.4, -6337.755)
	elif Jason.Dict["saved"] == 3:
		self.position =  Vector2(19157.293, -5509.017)
	elif Jason.Dict["saved"] == 4:
		self.position =  Vector2(-22695, -4140)
	elif Jason.Dict["saved"] == 5:
		self.position =  Vector2(21650, -7440)
	

	
func add_bot():
	var bot_scene = load("res://Robot.tscn")
	var bot_node = bot_scene.instance()
	var bot_scene2 = load("res://Robot.tscn")
	var bot_node2 = bot_scene2.instance()
	get_node("/root/").add_child(bot_node)
	get_node("/root/").add_child(bot_node2)
	bot_node.position = Vector2(-19310.002, -6306)
	bot_node2.position = Vector2(-19771.002, -6147)
	
func add_scorpion():
	var scorpion_scene = load("res://scorpion.tscn")
	var scorpion_node = scorpion_scene.instance()
	var scorpion_scene2 = load("res://scorpion.tscn")
	var scorpion_node2 = scorpion_scene2.instance()
	get_node("/root/Game").add_child(scorpion_node)
	get_node("/root/Game").add_child(scorpion_node2)
	scorpion_node.position = Vector2(-16052, -2409)
	scorpion_node2.position = Vector2(-16375, -1990)
func add_scorpion2():
	var scorpion_scene = load("res://scorpion.tscn")
	var scorpion_node = scorpion_scene.instance()
	var scorpion_scene2 = load("res://scorpion.tscn")
	var scorpion_node2 = scorpion_scene2.instance()
	get_node("/root/Game").add_child(scorpion_node)
	get_node("/root/Game").add_child(scorpion_node2)
	scorpion_node.position = Vector2(-14000, -268)
	scorpion_node2.position = Vector2(-13490, 17)
func add_scorpion3():
	var scorpion_scene = load("res://scorpion.tscn")
	var scorpion_node = scorpion_scene.instance()
	var scorpion_scene2 = load("res://scorpion.tscn")
	var scorpion_node2 = scorpion_scene2.instance()
	get_node("/root/Game").add_child(scorpion_node)
	get_node("/root/Game").add_child(scorpion_node2)
	scorpion_node.position = Vector2(-2595, -7090)
	scorpion_node2.position = Vector2(-2925, -7090)
	
func add_spider():
	var spider_scene = load("res://spider.tscn")
	var spider_node = spider_scene.instance()
	var spider_scene2 = load("res://spider.tscn")
	var spider_node2 = spider_scene2.instance()
	get_node("/root/Game").add_child(spider_node)
	get_node("/root/Game").add_child(spider_node2)
	spider_node.position = Vector2(1346, -871)
	spider_node2.position = Vector2(1047, -1542)
func add_spider2():
	var spider_scene = load("res://spider.tscn")
	var spider_node = spider_scene.instance()
	var spider_scene2 = load("res://spider.tscn")
	var spider_node2 = spider_scene2.instance()
	get_node("/root/Game").add_child(spider_node)
	get_node("/root/Game").add_child(spider_node2)
	spider_node.position = Vector2(2001.429, -2498.449)
	spider_node2.position = Vector2(1729.121, -2856.186)
func add_spider3():
	var spider_scene = load("res://spider.tscn")
	var spider_node = spider_scene.instance()
	var spider_scene2 = load("res://spider.tscn")
	var spider_node2 = spider_scene2.instance()
	get_node("/root/Game").add_child(spider_node)
	get_node("/root/Game").add_child(spider_node2)
	spider_node.position = Vector2(-2895, -4130)
	spider_node2.position = Vector2(-2901, -3777)
func add_spider4():
	var spider_scene = load("res://spider.tscn")
	var spider_node = spider_scene.instance()
	var spider_scene2 = load("res://spider.tscn")
	var spider_node2 = spider_scene2.instance()
	get_node("/root/Game").add_child(spider_node)
	get_node("/root/Game").add_child(spider_node2)
	spider_node.position = Vector2(13200, -7020)
	spider_node2.position = Vector2(13720, -7000)
	
func add_horse():
	var horse_scene = load ("res://Horse.tscn")
	var horse_node = horse_scene.instance()
	get_node("/root/Game").add_child(horse_node)
	horse_node.position = Vector2(13963.81, -7642.048)
	
func add_golem():
	var golem_scene = load ("res://golem.tscn")
	var golem_node = golem_scene.instance()
	get_node("/root/Game").add_child(golem_node)
	golem_node.position = Vector2(8792.05, -7994.52)
func add_golem2():
	var golem_scene = load ("res://golem.tscn")
	var golem_node = golem_scene.instance()
	get_node("/root/Game").add_child(golem_node)
	golem_node.position = Vector2(3793, -7965)
func add_golem3():
	var golem_scene = load ("res://golem2.tscn")
	var golem_node = golem_scene.instance()
	get_node("/root/Game").add_child(golem_node)
	golem_node.position = Vector2(-66.594, -7043.047)

func check_health():
	if Jason.Dict["health"] ==0:
		$"../UI_MAIN/Healthz"
		

func health():
	if Jason.Dict["health"] == 75:
		$"../UI_MAIN/Healthz".value = 75
	elif Jason.Dict["health"] == 50:
		$"../UI_MAIN/Healthz".value = 50
	elif Jason.Dict["health"] == 25:
		$"../UI_MAIN/Healthz".value = 25
	elif Jason.Dict["health"] == 0:
		$"../UI_MAIN/Healthz".value = 0
		die()
		

# warning-ignore:unused_argument
func _on_areabird_body_entered(body):
	var bird_scene = load ("res://blackbirds.tscn")
	var bird_node = bird_scene.instance()
	get_node("/root/Game").add_child(bird_node)
	bird_node.position = Vector2(-3830, 1650)
	$"../areabird".queue_free()


# warning-ignore:unused_argument
func _on_arealizard_body_entered(body):
	var lizard_scene = load ("res://Lizard.tscn")
	var lizard_node = lizard_scene.instance()
	get_node("/root/Game").add_child(lizard_node)
	lizard_node.position = Vector2(-4199, -3897)
	$"../arealizard".queue_free()

func _on_arearthur_area_entered(area):
	var velocity = Vector2()
	if "minis" in area.name and sad ==false:
		timez.start(0.2)
		sad = true
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		#self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*2
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
		timez.start(0.1)
		yield(timez, "timeout")
		sad = false
	elif "areasphere" in area.name and timez.is_stopped():
		timez.start(0.5)
		MusicManager.arthur18()
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*1
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
	elif "first area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_spider()
	elif  "second area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_spider2()
	elif  "third area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_spider3()
	elif "fourth area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_scorpion2()
	elif "fifth area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_spider4()
	elif "sixth area" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_scorpion3()
	elif  "area scrap" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <5:
		Jason.Dict["enemy_count"] +=2
		timez.start(1)
		yield(timez, "timeout")
		add_bot()
		#$timez.start(2)
		#yield($timez, "timeout")
	elif  "area scorp" in area.name and timez.time_left == 0 and Jason.Dict["enemy_count"] <4:
		timez.start(1)
		yield(timez, "timeout")
		add_scorpion()
		Jason.Dict["enemy_count"] +=2
	elif  "area caval"  in area.name  and timez.time_left == 0 and horse_count == 0:
		timez.start(1)
		yield(timez, "timeout")
		horse_count = 1
		add_horse()
		$"../area caval".queue_free()
	elif "areabear" in area.name and Jason.Dict["bear"] == 0:
		Jason.Dict["bear"] =1
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.fox()
		$timez.start(15)
		yield($timez, "timeout")
		Jason.Dict["bear"] =2
	elif "areabear" in area.name and Jason.Dict["bear"] == 2:
		Jason.Dict["bear"] =3
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.fox2()
		$timez.start(15)
		yield($timez, "timeout")
		Jason.Dict["bear"] =4
	elif "areabear" in area.name and Jason.Dict["bear"] == 4:
		Jason.Dict["bear"] =5
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.fox3()
		#$timez.start(15)
		#yield($timez, "timeout")
		
	elif "area beach" in area.name and Jason.Dict["done"] ==0:
		$"CanvasLayer2/Label beach/scroll".play("appear")
		$"../area beach".queue_free()
	elif "areasphere" in area.name and sad ==false:
		timez.start(0.2)
		sad = true
		MusicManager.arthur18()
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*2
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
		timez.start(0.1)
		yield(timez, "timeout")
		sad = false
	elif "areaexp" in area.name:
		timez.start(0.2)
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*2
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
	elif "travel" in area.name:
		$"../Door16".show()
	elif "doorto" in area.name:
		$"../UI_MAIN/ColorRect/tranx".play("tranx")
		yield($"../UI_MAIN/ColorRect/tranx", "animation_finished")
		$"../UI_MAIN/ColorRect/tranx".play_backwards("tranx")
		self.position = Vector2(-27186, -2250)
		set_process(false)
		$Pug.play("sit up")
		$Pug2.play("sit up")
		timez2.start(0.7)
		yield(timez2, "timeout")
		set_process(true)
	elif "return" in area.name:
		$"../UI_MAIN/ColorRect/tranx".play("tranx")
		yield($"../UI_MAIN/ColorRect/tranx", "animation_finished")
		$"../UI_MAIN/ColorRect/tranx".play_backwards("tranx")
		self.position = Vector2(-17650, 4730)
		set_process(false)
		$Pug.play("sit up")
		$Pug2.play("sit up")
		timez2.start(0.7)
		yield(timez2, "timeout")
		set_process(true)
	elif "keyarea" in area.name and Jason.Dict["done"] ==0:
		set_process(false)
		$Pug.play("sit up")
		$Pug2.play("sit up")
		$"../Pickup/TextureRect/Sprite".show()
	elif "book" in area.name:
		set_process(false)
		$Pug.play("sit up")
		$Pug2.play("sit up")
		$"../Pickup/TextureRect/Sprite2".show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif "maparea" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.map()
	elif "areashiba" in area.name and Jason.Dict["sam"] ==0 and Jason.Dict["talked"] ==0 :
		speechmanager.shiba()
		$Pug.play("sit up")
		$Pug2.play("sit up")
		Jason.Dict["talked"] =1
		Jason.Dict["sam"] =1
	elif "areashiba" in area.name and Jason.Dict["sam"] ==1  and Jason.Dict["talked"] ==1:
		speechmanager.shiba2()
		$Pug.play("sit up")
		$Pug2.play("sit up")
	elif "areashiba" in area.name and Jason.Dict["sam"] ==1 and Jason.Dict["talked"] ==3:
		speechmanager.shiba3()
		$Pug.play("sit up")
		$Pug2.play("sit up")
		$"../alpaca".position = Vector2(7905, 4205)
		Jason.Dict["talked"] =4
	elif "alpaca" in area.name and Jason.Dict["john"] ==0 and Jason.Dict["talked"] ==1:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.alpaca()
		Jason.Dict["john"] =1
	elif "alpaca" in area.name and Jason.Dict["john"] ==1 and Jason.Dict["talked"] ==2:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.alpaca2()
	elif "alpaca" in area.name and Jason.Dict["john"] ==1 and Jason.Dict["talked"] ==3:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.alpaca3()
	elif "alpaca" in area.name and Jason.Dict["john"] ==1 and Jason.Dict["talked"] ==4:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.alpaca4()
	elif "catarea" in area.name and Jason.Dict["done"] ==0:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.cat()
	elif "talkhawk" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.eagled()
		$"../birdexit".monitorable = true
		$"../birdexit".monitoring = true
	elif "uccellarea" in area.name :
		$"../Hawk".show()
		$"../Hawk".move()
		$Pug.play("sit left")
		$Pug2.play("sit left")
		speechmanager.eagle()
	elif "birdexit" in area.name:
		MusicManager.eagle()
		timez.start(1)
		yield(timez, "timeout")
		$"../Hawk".queue_free()
		$"../birdexit".queue_free()
		$"../glidearea".queue_free()
		$"../standarea".queue_free()
	elif "place" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.place()
	elif "parrotarea" in area.name and  Jason.Dict["sheep"] ==2:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.parrot()
	elif "sheeparea" in area.name and Jason.Dict["sheep"] ==0:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.paula()
	elif "gregs" in area.name and Jason.Dict["sheep"] ==1:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.greg()
		$"../parrot/Parrot/parrotarea".monitorable = true
		$"../parrot/Parrot/parrotarea".monitoring = true
		$"../parrot".show()
	elif "gregs" in area.name and Jason.Dict["sheep"] ==2  and Jason.Dict["book"] ==0:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.greg2()
	elif "gregs" in area.name and Jason.Dict["sheep"] ==2  and Jason.Dict["book"] ==1:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.greg3()
	elif "gregs" in area.name and Jason.Dict["sheep"] ==3 and Jason.Dict["book"] ==0:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.greg4()
	elif "area gorilla"in area.name:
		$Pug.play("sit right")
		$Pug2.play("sit right")
		speechmanager.gorilla()
	elif "areacrab" in area.name and crab == 0:
		$Pug.play("sit left")
		$Pug2.play("sit left")
		set_process(false)
		var resource = preload("res://dialogue1.tres")
		DialogueManager.show_example_dialogue_balloon("crab", resource)
		yield(DialogueManager, "dialogue_finished")
		set_process(true)
		crab =1
	elif "areacrab" in area.name and crab == 1:
		$Pug.play("sit left")
		$Pug2.play("sit left")
		set_process(false)
		var resource = preload("res://dialogue1.tres")
		DialogueManager.show_example_dialogue_balloon("crab2", resource)
		yield(DialogueManager, "dialogue_finished")
		crab =2
		set_process(true)
	elif "areacrab" in area.name and crab == 2:
		$Pug.play("sit left")
		$Pug2.play("sit left")
		set_process(false)
		var resource = preload("res://dialogue1.tres")
		DialogueManager.show_example_dialogue_balloon("crab3", resource)
		yield(DialogueManager, "dialogue_finished")
		crab =3
		set_process(true)
	elif "gater" in area.name:
		pass
	elif "heal" in area.name:
		$Pug.play("sit front")
		$Pug2.play("sit front")
		timez.start(1)
		Jason.Dict["health"] =100
		$"../UI_MAIN/Healthz".value = 100
		yield(timez, "timeout")
		speechmanager.heal()
	elif "orbarea" in area.name:
		$Pug.play("sit right")
		$Pug2.play("sit right")
		speechmanager.orb()
	elif "myarea" in area.name and timez.is_stopped():
		timez.start(0.3)
		MusicManager.arthur18()
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		#self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*2
		yield(timez, "timeout")
		Jason.Dict["health"] -= 25
		health()
		check_health()
	elif "activearea" in area.name:
		if Jason.Dict["torchdone"] !=0:
			$"../winter".monitorable = true
			$"../winter".monitoring = true
		elif Jason.Dict["torchdone"] ==0:
			$"../winter".monitorable = false
			$"../winter".monitoring = false
	elif "shrinemain" in area.name and Jason.Dict["papermain"] ==0:
		Jason.Dict["papermain"] = 1
		$"../shrine/shrinemain".queue_free()
		$Pug.play("sit up")
		$Pug2.play("sit up")
		set_process(false)
		$"../shrine/map".queue_free()
		$timez.start(1)
		yield($timez,"timeout")
		MusicManager.paper()
		$timez.start(1)
		yield($timez, "timeout")
		MusicManager.pageorb()
		$"../UI_MAIN/pageorb".show()
		$"../UI_MAIN/closemap".show()
		$"../UI_MAIN/Control4".hide()
		$"../UI_MAIN/Control3".hide()
		$"../UI_MAIN/Control2".hide()
		$"../UI_MAIN/Control".hide()
		$"../UI_MAIN/Healthz".hide()
		$"../UI_MAIN/TextureProgress4".hide()
		paper = true
	elif "gatewest" in area.name and Jason.Dict["kget"] !=2:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.locked()
	elif "gatewest" in area.name and Jason.Dict["kget"] ==2:
		set_process(false)
		$Pug.play("sit front")
		$Pug2.play("sit front")
		$"../UI_MAIN/padlock".frame = 0
		$"../gate west/gate".play("default")
		MusicManager.gate()
		$"../gate west/going".queue_free()
		$"../gate west/gatewest".queue_free()
		$"../UI_MAIN/padlock".show()
		$"../Lock west".queue_free()
		$"../UI_MAIN/padlock".play("default")
		MusicManager.lock()
		Jason.Dict["gateopen"] =2
		yield($"../UI_MAIN/padlock", "animation_finished")
		$"../UI_MAIN/padlock".hide()
		set_process(true)
	elif "gateeast" in area.name and Jason.Dict["kget"] !=1:
		$Pug.play("sit front")
		$Pug2.play("sit front")
		speechmanager.locked()
	elif "gateeast" in area.name and Jason.Dict["kget"] ==1:
		set_process(false)
		$Pug.play("sit front")
		$Pug2.play("sit front")
		$"../UI_MAIN/padlock".frame = 0
		$"../gate east/gate2".play("default")
		MusicManager.gate()
		$"../gate east/going".call_deferred("set", "disabled", true)
		$"../UI_MAIN/padlock".show()
		$"../Lock east".hide()
		$"../UI_MAIN/padlock".play("default")
		MusicManager.lock()
		yield($"../UI_MAIN/padlock", "animation_finished")
		$"../UI_MAIN/padlock".hide()
		Jason.Dict["gateopen"] =1
		set_process(true)
		$"../maintimer".start(1)
		yield($"../maintimer","timeout")
		$"../gate east/gateeast".queue_free()
	elif "winter" in area.name:
		Jason.Dict["area"] = 3
		Jason.Dict["done"] =1
		Jason.Dict["ever_saved"] = 1
		Jason.Dict["saved"] = 5
		GlobalLabel.timer_on = false
		Jason.save_game()
		MusicManager.none()
		var three_scene = "res://SCENE/winter.tscn"
		var loader3 = ResourceLoader.load_interactive(three_scene)
		if loader3 == null:
			print("error occured while getting the scene")
			return
		while true:
			var error = loader3.poll()
			if error == OK:
				var progress_bar = $"../UI_MAIN/ProgressBar"
				var value  = float(loader3.get_stage())/loader3.get_stage_count() 
				progress_bar.value = value *100
				yield(get_tree(), "idle_frame")
			elif error == ERR_FILE_EOF:
				var scene = loader3.get_resource().instance()
				yield(get_tree().create_timer(0.5),"timeout")
				get_tree().get_root().call_deferred("add_child",scene)
				$"..".queue_free()
				return
			else:
				print('error occurred while loading chunks of data')
				return
			$"../UI_MAIN/ProgressBar".show()
			$"../UI_MAIN/mainrect".show()
	elif "caves" in area.name:
		Jason.Dict["area"] = 4
		Jason.Dict["done"] =1
		Jason.Dict["ever_saved"] = 1
		#GlobalLabel.stoptime()
		GlobalLabel.timer_on = false
		Jason.save_game()
		MusicManager.none()
		var three_scene = "res://Caves.tscn"
		var loader3 = ResourceLoader.load_interactive(three_scene)
		if loader3 == null:
			print("error occured while getting the scene")
			return
		while true:
			var error = loader3.poll()
			if error == OK:
				var progress_bar = $"../UI_MAIN/ProgressBar"
				var value  = float(loader3.get_stage())/loader3.get_stage_count() 
				progress_bar.value = value *100
				yield(get_tree(), "idle_frame")
			elif error == ERR_FILE_EOF:
				var scene = loader3.get_resource().instance()
				yield(get_tree().create_timer(0.5),"timeout")
				get_tree().get_root().call_deferred("add_child",scene)
				$"..".queue_free()
				return
			else:
				print('error occurred while loading chunks of data')
				return
			$"../UI_MAIN/ProgressBar".show()
			$"../UI_MAIN/mainrect".show()
		

	


func _on_Exit_to_menu_pressed():
	pass # Replace with function body.
