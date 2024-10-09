class_name MainScene
extends Control

func UpdateSplashes():
	if DiscordRPC.get_is_discord_working():
		SplashStrings = ["Total listening time: %s!" % str(str(int(TimeSpentListening/60)/60 )
			 + "h : " + str((int(TimeSpentListening) / 60) % 60) + "m : " + 
			str(int(TimeSpentListening) % 60) + "s"),
			"Version: %s" % version.text,"🤷‍♂️","This Changes every ~11 seconds",
			"hello everybody my name is %s" % DiscordRPC.get_current_user()["username"],
			"wash your dishes, i know you got some","Running on %s" % OS.get_distribution_name(),
			"%s is cooking" % DiscordRPC.get_current_user()["username"], "debugging" if OS.has_feature("editor") else "Release build",
			"this user chose to show you all this info","Playing a Banger",
			":steamhappy:","This is a sign that crocodiles live in water",
			"Space? SPACE?! SPAAAAAAAAAAAAACE!!!",
			"i love gd colonge",
			"listening with reverb" if settings_menu_child.reverb_check.button_pressed else
			"not listening with reverb","the cake is edible",
			"what a great song!","this message is useless",
			"stop reading these","why are you reading these",
			"hello from mars", "hello to mars","there is a fly in my room",
			"yippee!","What, are they allergic to bathtubs or something",
			"Did you know, a 737 can land with up to 33knots of wind!",
			"Welcome to todays JahresSchau",
			"ram is very useful","your cpu is tasty","main course: Nvidia GPU",
			"SCHOTTLAND FUER IMMER","i eat airborne vehicles","linus trovalds",
			"™","＼（〇_ｏ）／","Nuh Uh!","Yuh Huh","Breaching.",
			"I get a narcissistic injury when the wall ignores me","totally not using %s" % version.text] 


func SaveEverything():
	var Data:Dictionary = {
		"Version" : version.text,
		"Volume" : volume_slider.value,
		"Directory" : CurrentDir,
		"CurrIDX" : CurrentIDX,
		"Randomized" : Randomized,
		"Playing" : music_player.playing,
		"SeenWAVDisclaimer" : SeenWAVDisclaimer,
		"TimeSpentListening" : TimeSpentListening,
		"DiscordRichPresenceEnabled" : DiscordRichPresenceEnabled,
		"ReverbEnabled" : settings_menu_child.reverb_check.button_pressed,
		"ReverbRoomSize" : settings_menu_child.room_size_slider.value,
		"ReverbDampening" : settings_menu_child.dampening_size_slider.value,
		"ReverbSpread" : settings_menu_child.spread_size_slider.value,
		"CompressionEnabled" : settings_menu_child.compression_check.button_pressed,
		"CompressionThreshold" : settings_menu_child.threshold_slider.value ,
		"CompressionRatio" : settings_menu_child.ratio_slider.value ,
		"CompressionGain" : settings_menu_child.gain_slider.value,
		"CurrentCustomBackroundImageDirectory" : CurrentCustomBackroundImageDirectory,
		"PlayAllLists" : PlayAllLists
	}
	saveUserdata(Data)
	savePlaylists()

func savePlaylists():
	var json = JSON.new()
	var file = FileAccess.open("user://playlists.dat", FileAccess.WRITE)
	var file2 = FileAccess.open("user://playlistsLocation.dat", FileAccess.WRITE)
	@warning_ignore("static_called_on_instance")
	if !Playlists == null or !Playlists == {}:
		file.store_string(str(json.stringify(Playlists)))
	if !PlaylistsLocation == null or !PlaylistsLocation == {}:
		file2.store_string(str(json.stringify(PlaylistsLocation)))


func saveUserdata(content):
	var json = JSON.new()
	var file = FileAccess.open("user://data.dat", FileAccess.WRITE)
	@warning_ignore("static_called_on_instance")
	file.store_string(Marshalls.utf8_to_base64(json.stringify(content)))
	file.close()

func loadUserdata():
	var json = JSON.new()
	var file = FileAccess.open("user://data.dat", FileAccess.READ)
	var filetext = file.get_as_text() if file != null else null
	if file != null:
		var content
		if json.parse_string(file.get_as_text()) != null:
			content = json.parse_string(filetext)
		else:
			@warning_ignore("static_called_on_instance")
			content = json.parse_string(Marshalls.base64_to_utf8(file.get_as_text()))
		file.close()
		return content
	else: 
		file.close()
		return null

func loadPlaylists():
	var json = JSON.new()
	var file = FileAccess.open("user://playlistsLocation.dat", FileAccess.READ)
	var file2 = FileAccess.open("user://playlists.dat", FileAccess.READ)
	var filetext = file.get_as_text()
	print("Playlists")
	print(filetext)
	#print("shit " + json.parse_string(filetext))
	if file.get_as_text() != "" and file2.get_as_text() != "":
		PlaylistsLocation = json.parse_string(file.get_as_text())
		Playlists = {} if json.parse_string(file2.get_as_text()) == null else json.parse_string(file2.get_as_text())
		print(PlaylistsLocation)
		print(Playlists.keys())
		print("Playlists")
	file.close()
	file2.close()
