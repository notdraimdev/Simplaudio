class_name PlayManager
extends Node

@export var dataHandler:DataHandler
@export var audioPlayerController:AudioPlayerController
signal PlayingNewSong
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audioPlayerController.SongFinished.connect(CurrentSongFinished)
	dataHandler.NewSongsAdded.connect(playSong)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func CurrentSongFinished():
	print(dataHandler.CurrentIdx + 1)
	print((dataHandler.CurrentIdx + 1) % (dataHandler.Songs.size()-1))
	print(dataHandler.Songs.size()-1)
	dataHandler.CurrentIdx = (dataHandler.CurrentIdx + 1) % (dataHandler.Songs.size()-1)
	playSong(dataHandler.CurrentIdx)

func playSongRelative(offset:int=1):
	dataHandler.CurrentIdx = (dataHandler.CurrentIdx + offset) % (dataHandler.Songs.size()-1)
	playSong(dataHandler.CurrentIdx)

func playSong(index:int=0):
	var song = FileAccess.get_file_as_bytes(dataHandler.Songs[index].Location)
	print("trying to play: ",dataHandler.Songs[index].Name)
	if song:
		var mp3:AudioStreamMP3 = AudioStreamMP3.new()
		mp3.data = song
		audioPlayerController.SetSong(mp3)
		audioPlayerController.PlaySong()
		if index != 0:
			PlayingNewSong.emit()
	else:
		printerr("audio file invalid")