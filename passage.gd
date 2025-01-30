extends Node2D


onready var cursor = get_node("Cursor")
var mouse_pos = Vector2()
var mouse_speed = 6.0
var ghost = load("res://ghost.tscn")
var ghosty = preload ("res://Arthur/Pug music/godd.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Jason.save_game()
	MusicManager.spooky()



func _process(delta):
	var mouse_rel = Vector2.ZERO
	if Input.is_action_pressed("uppad"):
		mouse_rel += Vector2.UP * mouse_speed
	elif Input.is_action_pressed("downpad"):
		mouse_rel += Vector2.DOWN * mouse_speed
	elif Input.is_action_pressed("leftpad"):
		mouse_rel += Vector2.LEFT * mouse_speed
	elif Input.is_action_pressed("rightpad"):
		mouse_rel += Vector2.RIGHT * mouse_speed
	if mouse_rel != Vector2.ZERO:
		Input.warp_mouse_position(mouse_pos + mouse_rel)
	cursor.position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
