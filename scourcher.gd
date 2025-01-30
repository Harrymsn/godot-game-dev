

extends KinematicBody2D

var movement = Vector2()
var speed = 250
var player_position
var target_position
var velocity = Vector2()
var can_move = true
var walk = true
var can_hit = true
var exep = false
func _ready():
	set_process(false)
	$hitarea.position = $CollisionShape2D.position
	self.position =  Vector2(8230, 16300)
	if Jason.Dict["intro"] ==1:
		pass
		#set_process(false)
	
		
	
	

func _process(_delta):
		player_position = $"../Arthur".position
		target_position = (player_position - position).normalized()
		move_and_slide(target_position * speed)
		
		
		if Jason.Dict["health"] ==0:
			set_process(false)
			speed = 0 
			$scourcher.play("idle down")
			$raycast.enabled = false
			$hitarea.monitorable = false
			$hitarea.monitoring = false 
			$CollisionShape2D.disabled
			can_move = false
			walk = false
			can_hit = false
		var collider = $raycast.get_collider()
		var angle = position.angle_to_point(player_position)
		var distance = position.distance_to(player_position)
		
		
		if angle >=-0.35 and angle <=0.35 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(-50, 0)
			$scourcher.scale.x = -1
			$scourcher.play("right")
			
		elif angle >=-0.35 and angle <=0.35 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0 :
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(-50, 0)
			$scourcher.scale.x = -1
			$scourcher.play("attack right")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(-130, 0)
			howto()
		
	
			
			
		elif angle >=0.35 and angle <= 1.05 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(-50, -50)
			$scourcher.scale.x = -1
			$scourcher.play("dur")
			
		elif angle >=0.35 and angle <= 1.05 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(-50, -50)
			$scourcher.scale.x = -1
			$scourcher.play("attack dur")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(-100, -100)
			howto()
		
		elif angle >=1.05 and angle <= 1.75 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(0, -50)
			$scourcher.scale.x = 1
			$scourcher.play("up")
		
		elif angle >=1.05 and angle <= 1.75 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(0, -50)
			$scourcher.scale.x = 1
			$scourcher.play("attack up")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(0, -180)
			howto()
		
					
			
		
		elif angle >=1.75 and angle <= 2.45 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(50, -50)
			$scourcher.scale.x = 1
			$scourcher.play("dur")
			
		elif angle >=1.75 and angle <= 2.45 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(50, -50)
			$scourcher.scale.x = 1
			$scourcher.play("attack dur")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(100, -100)
			howto()
			
		
		if angle >=2.45 and angle <=3.5 and  distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(50, 0)
			$scourcher.scale.x = 1
			$scourcher.play("right")
		
		
		if angle >=2.45 and angle <=3.5 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(50, 0)
			$scourcher.scale.x = 1
			$scourcher.play("attack right")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(130, 0)
			howto()
			
		elif angle >=-3.5 and angle <=-2.25 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(50, 50)
			$scourcher.scale.x = 1
			$scourcher.play("ddr")
			
		elif angle >=-3.5 and angle <=-2.25 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(50, 50)
			$scourcher.scale.x = 1
			$scourcher.play("attack ddr")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(100, 100)
			howto()
			
			
			
		elif angle >=-2.25 and angle <= -1.35 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(0, 50)
			$scourcher.scale.x = 1
			$scourcher.play("down")
			
		elif angle >=-2.25 and angle <= -1.35 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(0, 50)
			$scourcher.scale.x = 1
			$scourcher.play("attack down")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(0, 100)
			howto()
			
		elif angle >=-1.35 and angle <=-0.35 and distance >500 and walk == true:
			$hitarea.position = $CollisionShape2D.position
			$raycast.cast_to =Vector2(-50, 50)
			$scourcher.scale.x = -1
			$scourcher.play("ddr")
			
		elif angle >=-1.35 and angle <=-0.35 and distance <500 and can_move ==true and can_hit ==true and $Timer.time_left ==0:
			speed = 250
			walk = false
			$raycast.cast_to =Vector2(-50, 50)
			$scourcher.scale.x = -1
			$scourcher.play("attack ddr")
			$Timer.start(1)
			yield($Timer, "timeout")
			$hitarea.position = $raycast.position + Vector2(-100, 100)
			howto()
		
	
func howto():
	can_hit = false
	can_move = false
	$Timer.start(0.6)
	yield($Timer, "timeout")
	$hitarea.position = $CollisionShape2D.position
	#$scourcher.play("idle right")
	speed = 0
	$Timer.start(2)
	yield($Timer, "timeout")
	can_hit = true
	can_move = true
	walk = true
	speed =250

func respawn():
	self.position = Vector2(4750, 8790)
	set_process(true)
	speed = 250
	$scourcher.play("idle down")
	$raycast.enabled = true
	$hitarea.monitorable = true
	$hitarea.monitoring = true
	$CollisionShape2D.disabled = false
	can_move = true
	walk = true
	can_hit = true
			
			
		
			
		


func _on_hitarea_area_entered(area):
	if "arearthur" in area.name and Jason.Dict["health"] !=0:
		$timer2.start(1)
		can_hit = false
		$hitarea.position = $CollisionShape2D.position
		yield($timer2, "timeout")
		can_hit = true
	elif "arearthur" in area.name and Jason.Dict["health"] ==0:
		can_hit = false
	#elif "portarea" in area.name:
		#$timer2.start(1)
		#yield($timer2,"timeout")
		#$AnimationPlayer.play("jump over")
		#yield($AnimationPlayer, "animation_finished")
		#$".".position = Vector2(8258.769, 11900)
	#elif "movearea" in area.name:
		#$AnimationPlayer.play("move")
		#yield($AnimationPlayer, "animation_finished")
		#$timer2.start(1)
		#yield($timer2,"timeout")
		#$".".position = Vector2(3657, 3120)
		
	
		
		
