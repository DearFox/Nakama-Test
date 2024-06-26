extends Node

# For developers to set from the outside, for example:
#   Online.nakama_host = 'nakama.example.com'
#   Online.nakama_scheme = 'https'
var nakama_server_key: String = 'defaultkey'
var nakama_host: String = 'localhost'
var nakama_port: int = 7350
var nakama_scheme: String = 'http'

# For other scripts to access:
#var nakama_client: NakamaClient setget _set_readonly_variable, get_nakama_client
var _nakama_client: NakamaClient = null
var nakama_client: NakamaClient: get = get_nakama_client
	
var _nakama_session: NakamaSession = null
var nakama_session: NakamaSession: set = set_nakama_session, get = get_nakama_session
	
var _nakama_socket: NakamaSocket = null
var nakama_socket: NakamaSocket: get = get_nakama_socket

# Internal variable for initializing the socket.
var _nakama_socket_connecting := false

signal session_changed (nakama_session)
signal session_connected (nakama_session)
signal socket_connected (nakama_socket)

func _set_readonly_variable(_value) -> void:
	pass

func _ready() -> void:
	# Don't stop processing messages from Nakama when the game is paused.
	#Nakama.pause_mode = Node.PROCESS_MODE_ALWAYS
	#Nakama.pause_mode = Node.PAUSE_MODE_PROCESS
	pass

func get_nakama_socket() -> NakamaSocket:
	#if _nakama_socket == null:
		#print('nakama socket is null, creating one')
		#connect_nakama_socket()
		#await socket_connected
		#print(_nakama_socket)
	return _nakama_socket

func get_nakama_client() -> NakamaClient:
	if _nakama_client == null:
		_nakama_client = Nakama.create_client(
			nakama_server_key,
			nakama_host,
			nakama_port,
			nakama_scheme,
			Nakama.DEFAULT_TIMEOUT,
			NakamaLogger.LOG_LEVEL.ERROR)
	
	return _nakama_client

func get_nakama_session() -> NakamaSession:
	return _nakama_session

func set_nakama_session(nakama_session_: NakamaSession) -> void:
	# Close out the old socket.
	if _nakama_socket:
		_nakama_socket.close()
		_nakama_socket = null
	
	_nakama_session = nakama_session_
	
	emit_signal("session_changed", nakama_session)
	
	if nakama_session and not nakama_session.is_exception() and not nakama_session.is_expired():
		emit_signal("session_connected", nakama_session)

func connect_nakama_socket() -> void:
	if _nakama_socket != null:
		return
	if _nakama_socket_connecting:
		return
	
	_nakama_socket_connecting = true
	
	var new_socket = Nakama.create_socket_from(nakama_client)
	#yield(new_socket.connect_async(nakama_session), "completed")
	#await new_socket.connect_async(nakama_session)
	var _connection = await new_socket.connect_async(nakama_session)
	_nakama_socket = new_socket
	_nakama_socket_connecting = false
	
	emit_signal("socket_connected", nakama_socket)

func is_nakama_socket_connected() -> bool:
	return _nakama_socket != null && _nakama_socket.is_connected_to_host()
