extends Node


# Declare member variables here. Examples:
# var a = 2
var resource = preload("res://dialogue1.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func grave():
	$"../Arthur".set_process(false)
	DialogueManager.show_example_dialogue_balloon("grave", resource)
	MusicManager.arthurgrave()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave2", resource)
	MusicManager.arthurgrave2()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave3", resource)
	MusicManager.arthurgrave3()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave4", resource)
	MusicManager.arthurgrave4()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave5", resource)
	MusicManager.arthurgrave5()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave6", resource)
	MusicManager.arthurgrave6()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave7", resource)
	MusicManager.arthurgrave7()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave8", resource)
	MusicManager.arthurgrave8()
	yield(DialogueManager, "dialogue_finished")
	$"../UI_MAIN/Control".set_process(true)
	$"../UI_MAIN/Control2".set_process(true)
	$"../UI_MAIN/Control3".set_process(true)
	$"../UI_MAIN/Control4".set_process(true)
	$"../Arthur".set_process(true)
func grave2():
	$"../Arthur".set_process(false)
	$"../UI_MAIN/Control".set_process(false)
	$"../UI_MAIN/Control2".set_process(false)
	$"../UI_MAIN/Control3".set_process(false)
	$"../UI_MAIN/Control4".set_process(false)
	DialogueManager.show_example_dialogue_balloon("grave9", resource)
	MusicManager.arthurgrave9()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave10", resource)
	MusicManager.arthurgrave10()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("grave11", resource)
	MusicManager.arthurgrave11()
	yield(DialogueManager, "dialogue_finished")
	$"../UI_MAIN/Control".set_process(true)
	$"../UI_MAIN/Control2".set_process(true)
	$"../UI_MAIN/Control3".set_process(true)
	$"../UI_MAIN/Control4".set_process(true)
	$"../Arthur".set_process(true)
	
func orb():
	$"../Arthur".set_process(false)
	$"../UI_MAIN/Control".set_process(false)
	$"../UI_MAIN/Control2".set_process(false)
	$"../UI_MAIN/Control3".set_process(false)
	$"../UI_MAIN/Control4".set_process(false)
	$"../orb/orbarea".queue_free()
	$"../orb/AnimationPlayer".play("orb")
	Jason.Dict["torch"] =3
	MusicManager.orb()
	yield($"../orb/AnimationPlayer", "animation_finished")
	$"../orb".queue_free()
	$timez.start(2)
	yield($timez, "timeout")
	DialogueManager.show_example_dialogue_balloon("orb6", resource)
	MusicManager.orbgrave()
	yield(DialogueManager, "dialogue_finished")
	$"../UI_MAIN/Control".set_process(true)
	$"../UI_MAIN/Control2".set_process(true)
	$"../UI_MAIN/Control3".set_process(true)
	$"../UI_MAIN/Control4".set_process(true)
	$"../Arthur".set_process(true)
	Jason.Dict["orb3"] =1
	$"../Door19".show()
	$"../Door19/areabackcave".monitorable = true
	$"../Door19/areabackcave".monitoring = true

	
func dead():
	$"../Arthur".set_process(false)
	DialogueManager.show_example_dialogue_balloon("dead", resource)
	MusicManager.dead()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("dead2", resource)
	MusicManager.dead2()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("dead3", resource)
	MusicManager.dead3()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("dead4", resource)
	MusicManager.dead4()
	yield(DialogueManager, "dialogue_finished")
	$"../Arthur".set_process(true)
	
func deer():
	$"../Arthur".set_process(false)
	DialogueManager.show_example_dialogue_balloon("deer", resource)
	MusicManager.deer()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer2", resource)
	MusicManager.deer2()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer3", resource)
	MusicManager.deer3()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer4", resource)
	MusicManager.deer4()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer5", resource)
	MusicManager.deer5()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer6", resource)
	MusicManager.deer6()
	yield(DialogueManager, "dialogue_finished")
	DialogueManager.show_example_dialogue_balloon("deer7", resource)
	MusicManager.deer7()
	yield(DialogueManager, "dialogue_finished")
	$"../Arthur".set_process(true)
	
