extends Node

@export var button:Button
@export var buttonTexture:TextureRect
@export var audioPlayController:AudioPlayerController
@export var pauseImage:Texture
@export var playImage:Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(togglePlaying)

func togglePlaying():
	if !audioPlayController.player.stream_paused:
		buttonTexture.texture = playImage
		audioPlayController.SetSongPaused(true)
	else:
		buttonTexture.texture = pauseImage
		audioPlayController.SetSongPaused(false)