extends Node

@export var playManager:PlayManager
@export var audioPlayerController:AudioPlayerController
@export var FileNameDisplay:Label
@export var ArtistDisplay:Label
@export var AlbumDisplay:Label
@export var CoverDisplay:TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playManager.PlayingNewSong.connect(UpdateMetadata)

func UpdateMetadata(songInfo:SongInfo):
	FileNameDisplay.text = songInfo.Name.replacen(".mp3","")
	ArtistDisplay.text = songInfo.Author
	AlbumDisplay.text = songInfo.Album
	CoverDisplay.texture = MusicMetadataAutoload.get_mp3_metadata(audioPlayerController.player.stream).cover
	MusicMetadataAutoload.get_mp3_metadata(audioPlayerController.player.stream).print_info()