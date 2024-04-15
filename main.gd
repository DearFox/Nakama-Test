extends Node2D


func _get_custom_rpc_methods():
	return [
		"playerIsReady"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Control/ReadyScreen.connect("playerReady", playerReady)
	pass # Replace with function body.

func playerReady():
	OnlineMatch.custom_rpc_sync(self,"playerIsReady", [OnlineMatch.get_my_session_id()])

func playerIsReady(id):
	print(id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
