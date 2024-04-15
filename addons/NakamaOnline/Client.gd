extends Node

var client:NakamaClient

func _ready():
	client = Nakama.create_client("defaultkey", "127.0.0.1", 7350, "http")
	client.timeout = 10
