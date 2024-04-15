extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.visible = false
	OnlineMatch.connect("matchmaker_matched",OnMatchFound)
	pass # Replace with function body.

func OnMatchFound(players):
	print(players)
	pass


func _on_find_match_pressed():
	$FindMatch.visible = false
	$Label.visible = true
	if not Online.is_nakama_socket_connected():
		
		Online.connect_nakama_socket()
		print("connect_nakama_socket")
		await Online
		print("await Online.socket_connected")
	print("looking for a Match...")
	var data = {
		min_count = 2
	}
	OnlineMatch.start_matchmaking(Online.nakama_socket, data)
	pass # Replace with function body.
