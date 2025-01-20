

extends KinematicBody2D

var velocity = Vector2()
var speed = 150
signal sphere_launched
var player_position
var target_position
var sphere_count = 1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _ready():
	pass


func _physics_process(_delta):
		player_position = Jason.Dict["main_position"]
		target_position = (Jason.Dict["main_position"] - position).normalized()
		if position.distance_to(player_position) <3000:
# warning-ignore:return_value_discarded
			move_and_slide(target_position * speed)

		else:
			self.queue_free()
			Jason.Dict["enemy_count"] -=1
		var collider = $raycast.get_collider()
		if collider != null and "Arthur" in collider.name:
			collider.position =  collider.position + $raycast.cast_to.snapped(velocity)*2
			set_physics_process(false)
			$timerbot.start(0.5)
			yield($timerbot,"timeout")
			Jason.Dict["health"] -= 25
			set_physics_process(true)
		if Jason.Dict["health"]==0:
			$raycast.enabled = false
			$timerbot.start(2)
			yield($timerbot, "timeout")
			$raycast.enabled = true
			self.queue_free()
			
			
		if position.angle_to_point(player_position) >=-0.35 and position.angle_to_point(player_position) <=0.35:
			$raycast.cast_to =Vector2(-50, 0)
			$Robot.play("left")
			$Robot2.play("left")
		if position.angle_to_point(player_position) >=0.35 and position.angle_to_point(player_position) <= 1.05:
			$raycast.cast_to =Vector2(-50, -50)
			$Robot.play("DUL")
			$Robot2.play("DUL")
		if position.angle_to_point(player_position) >=1.05 and position.angle_to_point(player_position) <= 1.75:
			$raycast.cast_to =Vector2(0, -50)
			$Robot.play("up")
			$Robot2.play("up")
		if position.angle_to_point(player_position) >=1.75 and position.angle_to_point(player_position) <= 2.45:
			$raycast.cast_to =Vector2(50, -50)
			$Robot.play("DUR")
			$Robot2.play("DUR")
		if position.angle_to_point(player_position) >=2.45 and position.angle_to_point(player_position) <=3.5:
			$raycast.cast_to =Vector2(50, 0)
			$Robot.play("right")
			$Robot2.play("right")
		if position.angle_to_point(player_position) >=-3.5 and position.angle_to_point(player_position) <=-2.25:
			$raycast.cast_to =Vector2(50, 50)
			$Robot.play("DDR")
			$Robot2.play("DDR")
		if position.angle_to_point(player_position) >=-2.25 and position.angle_to_point(player_position) <= -1.35:
			$raycast.cast_to =Vector2(0, 50)
			$Robot.play("down")
			$Robot2.play("down")
		if position.angle_to_point(player_position) >=-1.35 and position.angle_to_point(player_position) <=-0.35:
			$raycast.cast_to =Vector2(-50, 50)
			$Robot.play("DDL")
			$Robot2.play("DDL")
		
			
		
		if position.distance_to(player_position) >200 and position.distance_to(player_position) <700 and $timerbot.time_left==0:
			$timerbot.start(2)
			yield($timerbot, "timeout")
			emit_signal("sphere_launched")
			#set_physics_process(false)
			launch_sphere()
			sphere_count = 0
			$timerbot.start(2)
			yield($timerbot, "timeout")
			#set_physics_process(true)
			sphere_count = 1
	

		
			
		# LIST OF FUNCTIONS

func launch_sphere():
	var sphere_scene = load("res://SCENE/sphere.tscn")
	var sphere_node = sphere_scene.instance()
	sphere_node.position = self.position + $raycast.cast_to.normalized()*130
	sphere_node.apply_impulse(Vector2(), $raycast.cast_to.normalized()*1500)
	sphere_node.set_angular_velocity(300)
	sphere_node.look_at(player_position)
	get_node("/root/Game").add_child(sphere_node)

func launch_fire():
	var fire_scene = load("res://SCENE/fire.tscn")
	var fire_node = fire_scene.instance()
	fire_node.position = self.position + $raycast.cast_to.normalized()*130
	fire_node.apply_impulse(Vector2(), $raycast.cast_to.normalized()*1500)
	fire_node.set_angular_velocity(300)
	fire_node.look_at(player_position)
	get_node("/root/Game").add_child(fire_node)

func launch_ice():
	var ice_scene = load("res://SCENE/ice.tscn")
	var ice_node = ice_scene.instance()
	ice_node.position = self.position + $raycast.cast_to.normalized()*130
	ice_node.apply_impulse(Vector2(), $raycast.cast_to.normalized()*1500)
	ice_node.set_angular_velocity(300)
	ice_node.look_at(player_position)
	get_node("/root/Game").add_child(ice_node)
	
		
	
		

		
		




func _on_botz_area_entered(area):
	if "icearea" in area.name:
		set_physics_process(false)
		$Robot.play("spin")
		yield($Robot, "animation_finished")
		set_physics_process(true)
	elif "firearea" in area.name:
		set_physics_process(false)
		$Robot.play("spin")
		yield($Robot, "animation_finished")
		set_physics_process(true)
