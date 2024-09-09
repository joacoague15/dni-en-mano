extends Node

var name_label
var born_date_label
var due_date_label
var portrait_sprite

func _ready():
	name_label = $NameLabel
	born_date_label = $BornDateLabel
	due_date_label = $DueDateLabel
	portrait_sprite = $PortraitSprite

func display_person_dni(dni):
	if dni:
		name_label.text = "Nombre: " + dni["name"]
		born_date_label.text = "Nacimiento: " + dni["born_date"]
		due_date_label.text = "Vencimiento: " + dni["due_date"]
		portrait_sprite.texture = dni["document_photo"]
		portrait_sprite.visible = true
	else:
		clear_display()

func clear_display():
	name_label.text = ""
	born_date_label.text = ""
	due_date_label.text = ""
	portrait_sprite.visible = false
