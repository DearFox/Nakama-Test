extends Control


func _ready():
	$"../ReadyScreen".visible = false

func _on_register_pressed():
	var username = $RichTextLabel/UsernameText.text.strip_edges()
	var password = $RichTextLabel/PasswordText.text.strip_edges()
	var email = $RichTextLabel/EmainText.text.strip_edges()
	$Errors.text = ""
	#if username and password and password:
	var session = await Online.nakama_client.authenticate_email_async(email, password, username, true)
	if session.is_exception():
		$Errors.text = session.get_exception().message
	else :
		Online.nakama_session = session
		visible = false
		$"../FindMatch".visible = true


func _on_login_pressed():
	var username = $RichTextLabel/UsernameText.text.strip_edges()
	var password = $RichTextLabel/PasswordText.text.strip_edges()
	var email = $RichTextLabel/EmainText.text.strip_edges()
	$Errors.text = ""
	#if username and password and password:
	var session = await Online.nakama_client.authenticate_email_async(email, password, null, false)
	if session.is_exception():
		$Errors.text = session.get_exception().message
	else :
		Online.nakama_session = session
		#print(session.username)
		visible = false
		$"../FindMatch".visible = true
	pass # Replace with function body.
