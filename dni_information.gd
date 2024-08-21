extends Control

var name_label
var born_date_label
var due_date_label
var photo_sprite

func _ready():
	name_label = $NameLabel
	born_date_label = $BornDateLabel
	due_date_label = $DueDateLabel
	photo_sprite = $PhotoSprite

func display_person_dni(dni):
	if dni:
		name_label.text = "Nombre: " + dni["name"]
		born_date_label.text = "Fecha de nacimiento: " + dni["born_date"]
		due_date_label.text = "Fecha de vencimiento: " + dni["due_date"]
		photo_sprite.texture = dni["document_photo"]
		photo_sprite.visible = true
	else:
		clear_display()

func clear_display():
	name_label.text = ""
	born_date_label.text = ""
	due_date_label.text = ""
	photo_sprite.visible = false
