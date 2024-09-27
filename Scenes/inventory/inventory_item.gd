extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var stackable: bool

func change(new_texture: Texture2D):
	texture = new_texture
