extends AspectRatioContainer
@onready var label: RichTextLabel = $VBoxContainer/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await draw
	var file = FileAccess.open("user://data.dat", FileAccess.READ)
	print(file.get_path_absolute())
	label.text = label.text.replace(".DIR.",file.get_path_absolute().replace("data.dat",""))
	DisplayServer.clipboard_set(file.get_path_absolute().replace("data.dat",""))
	OS.shell_open("https://ffmpeg.org/download.html#build-linux")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	hide()
