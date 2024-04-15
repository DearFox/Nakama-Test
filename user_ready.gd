extends Control

var ready_:String
var username:String

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setReady(readytext:String):
	$Ready.text = readytext
	ready_ = readytext

func setUsername(currentUsername:String):
	$UserName.text = currentUsername
	username = currentUsername
