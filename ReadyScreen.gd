extends Control

var USER_READY = preload("res://user_ready.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	OnlineMatch.connect("player_joined",PlayerJoined)
	OnlineMatch.connect("player_left",PlayerLeft)
	OnlineMatch.connect("player_status_changed",PlayerStatusChanged)
	OnlineMatch.connect("match_ready",MatchReady)
	OnlineMatch.connect("match_not_ready",MatchNotReady)
	OnlineMatch.connect("matchmaker_matched",AddPlayers)
	pass # Replace with function body.

func AddPlayers(players):
	for id in players:
		var userReady = USER_READY.instantiate()
		$VBoxContainer.add_child(userReady)
		userReady.setUsername(players[id]["username"])

func PlayerJoined (player):
	pass
func PlayerLeft (player):
	pass
func PlayerStatusChanged (player, status):
	pass
func MatchReady (players):
	pass
func MatchNotReady ():
	pass

func _on_im_ready_pressed():
	pass # Replace with function body.
