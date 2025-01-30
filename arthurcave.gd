extends KinematicBody2D


var next_scene = "res://testx.tscn"
var dead_scene = "res://Type7.tscn"
var timeless = "res://puzzle.tscn"
var grave = "res://Grave.tscn"
onready var timez = get_node("timez")
var sad = false
var scourcher = 0
var pressed = false
signal posplus
signal moves_pos
var speed = 350
var paper = false
var boss = 0
var can_die = false
onready var mesh = $MeshInstance2D
var oujen = preload("res://Oujen.tscn")
onready var  speechmanager = get_node("../Speechmanager")
var swoosh = preload("res://SCENE/fire.tscn")
var velocity = Vector2()

func _ready():
	Jason.Dict["killed"] = 0
	Jason.Dict["boss"] =1
	Jason.Dict["weaponhave"] =2
	GlobalLabel.timer_on = true
	Jason.Dict["area"] =4
	Jason.Dict["health"] =100
	$"../UI_MAIN/Healthz".value = 100
	if Jason.Dict["gravedone"] ==0:
		self.position = Vector2(8230, 17470)
		$"../Door17".hide()
		$"../backmain".monitorable = false
		$"../backmain".monitoring = false
		if Jason.Dict["intro"] ==1:
			$Pug.play("sit up")
			$Pug2.play("sit up")
			speechmanager.cave()
			Jason.Dict["intro"] = 2
	elif Jason.Dict["gravedone"] ==1:
		self.position = Vector2(7045, 2615)
		MusicManager.none()
		MusicManager.cave()
		Jason.Dict["saved"] =4
		#Jason.Dict["gravedone"] =0
	Jason.save_game()


func _process(delta):
	var velocity = Vector2()
	#$Camera2D.global_position = lerp($Camera2D.global_position, self.global_position, delta * 60)
	var fps = Engine.get_frames_per_second()
	var lerp_interval = velocity / fps
	var lerp_position = global_transform.origin + lerp_interval
	if fps >60:
		mesh.set_as_toplevel(true)
		mesh.global_transform.origin = mesh.global_transform.origin.linear_interpolate(lerp_position, 600*delta)
	else:
		mesh.global_transform = global_transform
		mesh.set_as_toplevel(false)
	if Input.is_key_pressed(KEY_R) and pressed ==true :
		$timez.start(0.075)
		speed = 1100
		yield($timez, "timeout")
		speed = 300
		
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
		
	if Jason.Dict["torchdone"] ==1:
		$"../torch1/fire1".play("fuocoz")
	elif Jason.Dict["torchdone"] ==2:
		$"../torch1/fire1".play("fuocoz")
		$"../torch2/fire2".play("fuocoz")
	elif Jason.Dict["torchdone"] ==3:
		$"../torch1/fire1".play("fuocoz")
		$"../torch2/fire2".play("fuocoz")
		$"../torch3/fire3".play("fuocoz")
	elif Jason.Dict["torchdone"] ==4:
		$"../torch1/fire1".play("fuocoz")
		$"../torch2/fire2".play("fuocoz")
		$"../torch3/fire3".play("fuocoz")
		$"../torch4/fire4".play("fuocoz")
	
	
		
	
	if Input.is_key_pressed(KEY_UP) or Input.is_action_pressed("uppad"):
		pressed = true
		velocity.y = -1
		$RayCast2D.cast_to =Vector2(0, -75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(0, -100)
		emit_signal("moves_pos")
	
	
	if Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_LEFT) or Input.is_action_pressed("uppad") and Input.is_action_pressed("leftpad"):
		pressed = true
		velocity.y = -0.5
		velocity.x = -0.5
		$RayCast2D.cast_to =Vector2(-75, -75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(-100, -100)
		emit_signal("moves_pos")
		
		
		
	elif Input.is_key_pressed(KEY_DOWN) and Input.is_key_pressed(KEY_LEFT) or Input.is_action_pressed("downpad") and Input.is_action_pressed("leftpad"):
		pressed = true
		velocity.y = 0.5
		velocity.x = -0.5
		$RayCast2D.cast_to =Vector2(-75, 75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(-100, 100)
		emit_signal("moves_pos")
	
	elif Input.is_key_pressed(KEY_UP) and Input.is_key_pressed(KEY_RIGHT)  or Input.is_action_pressed("uppad") and Input.is_action_pressed("rightpad"):
		pressed = true
		velocity.y = -0.5
		velocity.x = 0.5
		$RayCast2D.cast_to =Vector2(75, -75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(100, -100)
		emit_signal("moves_pos")
	elif Input.is_key_pressed(KEY_DOWN) and Input.is_key_pressed(KEY_RIGHT) or Input.is_action_pressed("downpad") and Input.is_action_pressed("rightpad") :
		pressed = true
		velocity.y = 0.5
		velocity.x = 0.5
		$RayCast2D.cast_to =Vector2(75, 75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(100, 100)
		emit_signal("moves_pos")
	
	elif Input.is_key_pressed(KEY_DOWN) or Input.is_action_pressed("downpad"):
		pressed = true
		velocity.y = 1
		$RayCast2D.cast_to =Vector2(0, 75)
		Jason.Dict["cave_position"] = self.global_position + Vector2(0, 100)
		emit_signal("moves_pos")
		
	elif Input.is_key_pressed(KEY_LEFT)  or Input.is_action_pressed("leftpad"):
		pressed = true
		velocity.x = -1
		$RayCast2D.cast_to =Vector2(-75, 0)
		Jason.Dict["cave_position"] = self.global_position + Vector2(-100, 0)
		emit_signal("moves_pos")
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_action_pressed("rightpad"):
		pressed = true
		velocity.x = 1
		$RayCast2D.cast_to =Vector2(75, 0)
		Jason.Dict["cave_position"] = self.global_position + Vector2(100, 0)
		emit_signal("moves_pos")
		
		

		
	var movement = speed *velocity.normalized()*delta
	self.move_and_collide(movement)
	self.update_animation(velocity)
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()


	
			
	
	
	if Jason.Dict["health"] != 100:
		health()
		check_health()
		
	var collider = $RayCast2D.get_collider()
	
	

func exec():
	$ProgressBar.show()
		
	
	

			

		
		
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
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") and Input.is_action_just_released("ui_left") :
		pressed = false
		$Pug.play("DSUL")
		$Pug2.play("DSUL")
	
	elif velocity == Vector2() and Input.is_action_just_released("uppad") and Input.is_action_just_released("leftpad") :
		$Pug.play("DSUL")
		$Pug2.play("DSUL")
		
	
	elif velocity.x == -0.5 and velocity.y == 0.5:
		$Pug.play("DDL")
		$Pug2.play("DDL")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") and Input.is_action_just_released("ui_left"):
		pressed = false
		#print(get_floor_angle())
		$Pug.play("DSDL")
		$Pug2.play("DSDL")
	
	elif velocity == Vector2() and Input.is_action_just_released("downpad") and Input.is_action_just_released("leftpad"):
		$Pug.play("DSDL")
		$Pug2.play("DSDL")
		
		
	elif velocity.y == -0.5 and velocity.x == 0.5:
		$Pug.play("DUR")
		$Pug2.play("DUR")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") and Input.is_action_just_released("ui_right"):
		pressed = false
		$Pug.play("DSUR")
		$Pug2.play("DSUR")
	
	elif velocity == Vector2() and Input.is_action_just_released("uppad") and Input.is_action_just_released("rightpad"):
		$Pug.play("DSUR")
		$Pug2.play("DSUR")
		
		
	elif velocity.y == 0.5 and velocity.x == 0.5:
		$Pug.play("DDR")
		$Pug2.play("DDR")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") and Input.is_action_just_released("ui_right"):
		pressed = false
		$Pug.play("DSDR")
		$Pug2.play("DSDR")
	
	elif velocity == Vector2() and Input.is_action_just_released("downpad") and Input.is_action_just_released("rightpad"):
		$Pug.play("DSDR")
		$Pug2.play("DSDR")
		
		  
	
	
	
	elif velocity == Vector2() and Input.is_action_just_released("ui_down") or Input.is_action_just_released("downpad"):
		pressed = false
		$Pug.play("sit front")
		$Pug2.play("sit front")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_right") or Input.is_action_just_released("rightpad"):
		pressed = false
		$Pug.play("sit right")
		$Pug2.play("sit right")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_left") or Input.is_action_just_released("leftpad"):
		pressed = false
		$Pug.play("sit left")
		$Pug2.play("sit left")
		
	elif velocity == Vector2() and Input.is_action_just_released("ui_up") or Input.is_action_just_released("uppad"):
		pressed = false
		$Pug.play("sit up")
		$Pug2.play("sit up")
		
func check_health():
	if Jason.Dict["health"] <1:
		$"../UI_MAIN/Healthz".value = 0
		

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

func launch_chicken():
	var chicken_scene = load("res://SCENE/chicken scene.tscn")
	var chicken_node = chicken_scene.instance()
	chicken_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	chicken_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*1000)
	chicken_node.set_angular_velocity(200)
	get_node("/root/Cave").add_child(chicken_node)
func launch_fire():
	var fire_scene = load("res://SCENE/fire.tscn")
	var fire_node = fire_scene.instance()
	fire_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	fire_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*2000)
	fire_node.set_angular_velocity(70)
	get_node("/root/Cave").add_child(fire_node)
	MusicManager.swoosh()
func launch_ice():
	var ice_scene = load("res://SCENE/ice.tscn")
	var ice_node = ice_scene.instance()
	ice_node.position = self.position + $RayCast2D.cast_to.normalized()*150
	ice_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*2000)
	ice_node.set_angular_velocity(400)
	get_node("/root/Cave").add_child(ice_node)
	MusicManager.icy_spell()

func die():
	Jason.Dict["killed"] = 1
	if  Jason.Dict["torchdone"] !=0 :
		$timez2.start(4)
		var respawn_scene = load("res://respawn.tscn")
		var respawn_node = respawn_scene.instance()
		var respawn_scene2 = load("res://respawn2.tscn")
		var respawn_node2 = respawn_scene2.instance()
		set_process(false)
		$Pug.play("death left")
		$Pug2.play("death left")
		#MusicManager.death()
		yield($timez2, "timeout")
		#Jason.Dict["coll"] =0
		$Pug.hide()
		$Pug2.hide()
		get_node("/root/Cave").add_child(respawn_node)
		respawn_node.position = self.position
		$timez2.start(2)
		yield($timez2, "timeout")
		$"../scourcher".respawn()
		self.position = Vector2(3585, 2515)
		#checkpoint()
		get_node("/root/Cave").add_child(respawn_node2)
		set_process(true)
		$timez2.start(0.7)
		Jason.Dict["health"] = 100
		$"../UI_MAIN/Healthz".value =100
		yield($timez2, "timeout")
		$Pug.show()
		$Pug2.show()
		$Pug.play("stand")
		$Pug2.play("stand")
		Jason.Dict["killed"] = 0
		#MusicManager.background()
	else:
		$timez2.start(5)
		GlobalLabel.timer_on = false
		set_process(false)
		$Pug.play("death left")
		$Pug2.play("death left")
		yield($timez2, "timeout")
		$"CanvasLayer3/Label GO/scroll".play("appear")
		$timez2.start(2)
		yield($timez2, "timeout")
		$"CanvasLayer3/Label GO/scroll".play("RESET")
		Jason.Dict["health"] = 100
		$"../UI_MAIN/Healthz".value =100
		MusicManager.none()
		Jason.Dict["killed"] = 0
		type7()
	#get_tree().change_scene("res://Type7.tscn")
func _on_arearthur_area_entered(area):
	if "first" in area.name and Jason.Dict["torch"] ==1:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		$"../torch1/fire1".play("fuocoz")
		Jason.Dict["saved"] =6
		Jason.Dict["torchdone"] =1
		speechmanager.torchlit()
	elif "second" in area.name and Jason.Dict["torch"] ==2:
		$"../torch2/fire2".play("fuocoz")
		Jason.Dict["torchdone"] =2
		$"../Door19".show()
		$"../Door19/areagrave/areagrave".call_deferred("set", "disabled", false)
	elif "third" in area.name and Jason.Dict["torch"] ==3:
		$"../torch3/fire3".play("fuocoz")
		Jason.Dict["torchdone"] =3
		$"../door3/door".play("default")
		$"../door3/colldoor".queue_free()
		Jason.Dict["boss"] =1
	elif "fourth" in area.name and Jason.Dict["torch"] ==4:
		Jason.Dict["torchdone"] =4
		$"../torch4/fire4".play("fuocoz")
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.lastorch()
	elif "pickice" in area.name:
		$"../ice/pickice".queue_free()
		$Pug.play("sit up")
		$Pug2.play("sit up")
		set_process(false)
		$"../ice/AnimatedSprite".show()
		$"../ice/AnimatedSprite".play("default")
		$"../ice/AnimationPlayer".play("go")
		yield($"../ice/AnimationPlayer", "animation_finished")
		$"../ice".queue_free()
		Jason.Dict["weaponhave"] = 3
		$"../UI_MAIN/Control".set_process(true)
		$"../UI_MAIN/Control/Sprite/TextureRect3".show()
		$AnimatedSprite.show()
		$AnimatedSprite.play("default")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.queue_free()
		speechmanager.power()
		Jason.Dict["weaponhave"] =3
	elif "movearea" in area.name and scourcher ==0:
		$"../scourcher".position = Vector2(3657, 3120)
		$"../scourcher".speed = 250
		scourcher = 1
	elif "movearea" in area.name and scourcher ==1:
		$"../scourcher".speed = 0
		$"../scourcher/scourcher".play("idle down")
	
	elif "portarea" in area.name and scourcher ==0:
		$"../scourcher".speed = 0
		$"../scourcher/scourcher".play("idleup")
	elif "portarea" in area.name and scourcher ==1:
		$"../scourcher".position = Vector2(8230, 16300)
		$"../scourcher".speed = 250
		scourcher = 0
		
	
		
		
		
	elif "gone" in area.name:
		$"../door/door".playing = false
		$"../door/door".frame = 0
		$"../door/colldoor".call_deferred("set", "disabled", false)
		$"../gone".queue_free()
		$"../scourcher".queue_free()
	elif "areaboss" in area.name and Jason.Dict["boss"] ==1:
		$"../areaboss".queue_free()
		$Pug.play("sit up")
		$Pug2.play("sit up")
		$"../areadeath/AnimationPlayer".play("appear")
		$"../areadeath/CollisionShape2D".call_deferred("set", "disabled", false)
		var boss_scene = load("res://boss.tscn")
		var boss_node = boss_scene.instance()
		get_node("/root/Cave").add_child(boss_node)
		boss_node.position = Vector2(7080, 2030)
		self.position = Vector2(7080, 3760)
		$Camera2D.position = Vector2(-124, -1000)
		speechmanager.oujen()
		
	elif "angelarea" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.astor()
	elif "areasphere" in area.name and sad ==false:
		timez.start(0.2)
		sad = true
		MusicManager.arthur18()
		$"../UI_MAIN/Anim2/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		#self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*2
		yield(timez, "timeout")
		Jason.Dict["health"] -= 20
		$"../UI_MAIN/Healthz".value  -=20
		health()
		check_health()
		timez.start(0.1)
		yield(timez, "timeout")
		sad = false
	elif "doora" in area.name:
		$"../Door17".show()
		$timez.start(1)
		yield($timez, "timeout")
		$"../backmain".monitorable = true
		$"../backmain".monitoring = true
	elif "hitarea" in area.name:
		timez.start(0.2)
		sad = true
		$"../Sprite3/Anim/Hit".play("Hit")
		$Camera2D/AnimationPlayer.play("shake")
		self.position = self.position - $RayCast2D.cast_to.snapped(velocity)*1
		yield($timez, "timeout")
		Jason.Dict["health"] -= 20
		$"../UI_MAIN/Healthz".value  -=20
		health()
		check_health()
		timez.start(0.1)
		yield(timez, "timeout")
		sad = false
	elif "orbarea" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		speechmanager.orbcave()
	elif "shrinecave" in area.name:
		$Pug.play("sit up")
		$Pug2.play("sit up")
		set_process(false)
		$"../shrine/shrinecave".queue_free()
		$timez.start(1)
		yield($timez, "timeout")
		$"../shrine/map".queue_free()
		MusicManager.paper()
		$timez.start(1)
		yield($timez, "timeout")
		MusicManager.pagecave()
		$"../UI_MAIN/pagecaves".show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$"../UI_MAIN/closemap".show()
		$"../UI_MAIN/Control4".hide()
		$"../UI_MAIN/Control3".hide()
		$"../UI_MAIN/Control2".hide()
		$"../UI_MAIN/Control".hide()
		$"../UI_MAIN/Healthz".hide()
		$"../UI_MAIN/TextureProgress4".hide()
		Jason.Dict["papercave"] =1
	
	
	elif "backmain" in area.name:
		Jason.Dict["saved"] =4
		GlobalLabel.timer_on = false
		set_process(false)
		$"../UI_MAIN/Healthz".hide()
		$"../UI_MAIN/Control".hide()
		$"../UI_MAIN/Control2".hide()
		$"../UI_MAIN/Control3".hide()
		$"../UI_MAIN/Control4".hide()
		$"../UI_MAIN/TextureProgress4".hide()
		MusicManager.none()
		Jason.save_game()
		Jason.Dict["area"] =1
		Jason.Dict["chicken_count"] = 0
		var loader3 = ResourceLoader.load_interactive(next_scene)
		if loader3 == null:
			print("error occured while getting the scene")
			return
		while true:
			var error = loader3.poll()
			if error == OK:
				var progress_bar = $"../CanvasLayer/ProgressBar"
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
			$"../CanvasLayer/ProgressBar".show()
			$"../UI_MAIN/mainrect".show()
		
	elif "areagrave" in area.name:
		Jason.Dict["saved"] =10
		Jason.Dict["area"] =6
		GlobalLabel.timer_on = false
		set_process(false)
		$"../UI_MAIN/Healthz".hide()
		$"../UI_MAIN/Control".hide()
		$"../UI_MAIN/Control2".hide()
		$"../UI_MAIN/Control3".hide()
		$"../UI_MAIN/Control4".hide()
		$"../UI_MAIN/TextureProgress4".hide()
		MusicManager.none()
		Jason.save_game()
		var loader3 = ResourceLoader.load_interactive(grave)
		if loader3 == null:
			#print("error occured while getting the scene")
			return
		while true:
			var error = loader3.poll()
			if error == OK:
				var progress_bar = $"../CanvasLayer/ProgressBar"
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
				#print('error occurred while loading chunks of data')
				return
			$"../CanvasLayer/ProgressBar".show()
			$"../UI_MAIN/mainrect".show()
		
	elif "areatimeless" in area.name:
		Jason.Dict["saved"] =9
		Jason.Dict["area"] =2
		GlobalLabel.timer_on = false
		set_process(false)
		$"../UI_MAIN/Healthz".hide()
		$"../UI_MAIN/Control".hide()
		$"../UI_MAIN/Control2".hide()
		$"../UI_MAIN/Control3".hide()
		$"../UI_MAIN/Control4".hide()
		$"../UI_MAIN/TextureProgress4".hide()
		MusicManager.none()
		Jason.save_game()
		Jason.Dict["chicken_count"] = 0
		var loader3 = ResourceLoader.load_interactive(timeless)
		if loader3 == null:
			#print("error occured while getting the scene")
			return
		while true:
			var error = loader3.poll()
			if error == OK:
				var progress_bar = $"../CanvasLayer/ProgressBar"
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
				#print('error occurred while loading chunks of data')
				return
			$"../CanvasLayer/ProgressBar".show()
			$"../UI_MAIN/mainrect".show()
			

func type7():
	Jason.Dict["dialogue"] =1
	$"../UI_MAIN/Healthz".hide()
	$"../UI_MAIN/Control".hide()
	$"../UI_MAIN/Control2".hide()
	$"../UI_MAIN/Control3".hide()
	$"../UI_MAIN/Control4".hide()
	$"../UI_MAIN/TextureProgress4".hide()
	var loader3 = ResourceLoader.load_interactive(dead_scene)
	if loader3 == null:
		print("error occured while getting the scene")
		return
	while true:
		var error = loader3.poll()
		if error == OK:
			var progress_bar = $"../CanvasLayer/ProgressBar"
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
			#print('error occurred while loading chunks of data')
			return
		$"../CanvasLayer/ProgressBar".show()
		$"../UI_MAIN/mainrect".show()
			#$"../CanvasLayer3/Now loading/AnimationPlayer".play("now loading")
