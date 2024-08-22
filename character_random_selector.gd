extends Node2D

@onready var dni_information = $DNIInformation

# Define the list of persons with their corresponding images
var persons = []

var pixel_art_persons = [
	{"name": "Camila", "image": preload("res://characterImages/camila.webp"), "dni": {"name": "Camila Gutierrez", "born_date": "15-01-1990", "due_date": "10-10-2026", "document_photo": preload("res://characterImages/camila.webp")}},
	{"name": "Franco", "image": preload("res://characterImages/franco.webp"), "dni": {"name": "Franco Perez", "born_date": "10-03-1997", "due_date": "20-02-2025", "document_photo": preload("res://characterImages/franco.webp")}},
	{"name": "Victoria", "image": preload("res://characterImages/victoria.webp"), "dni": {"name": "Victoria Ramirez", "born_date": "25-07-1995", "due_date": "01-12-2028", "document_photo": preload("res://characterImages/victoria.webp")}},
	{"name": "Juan", "image": preload("res://characterImages/juan.webp"), "dni": {"name": "Juan Ramirez", "born_date": "25-07-1998", "due_date": "05-05-2030", "document_photo": preload("res://characterImages/juan.webp")}},
	{"name": "Lucas", "image": preload("res://characterImages/lucas.webp"), "dni": {"name": "Lucas Vitz", "born_date": "13-11-1997", "due_date": "14-09-2027", "document_photo": preload("res://characterImages/lucas.webp")}},
	{"name": "Rosa", "image": preload("res://characterImages/rosa.webp"), "dni": {"name": "Rosa Yung", "born_date": "20-07-1995", "due_date": "10-10-2026", "document_photo": preload("res://characterImages/rosa.webp")}}
]

var vector_persons = [
		{"name": "Julieta", "image": preload("res://characterVectors/julieta.svg"), "dni": {"name": "Julieta Zuc", "born_date": "04-04-1992", "due_date": "05-05-2025", "document_photo": preload("res://characterVectors/julieta.svg")}},
		{"name": "Marcos", "image": preload("res://characterVectors/marcos.svg"), "dni": {"name": "Marcos Miller", "born_date": "12-06-1989", "due_date": "15-08-2029", "document_photo": preload("res://characterVectors/marcos.svg")}},
		{"name": "Sofia", "image": preload("res://characterVectors/sofia.svg"), "dni": {"name": "Sofia Ruth", "born_date": "14-01-1998", "due_date": "15-08-2027", "document_photo": preload("res://characterVectors/sofia.svg")}}
	]

var selected_index = -1

func _ready():
	persons = pixel_art_persons
	select_random_person()
	
func select_random_person():
	if persons.size() == 0:
		print("No more persons available.")
		$CharacterSprite.visible = false
		return
	selected_index = randi() % persons.size()
	var selected_person = persons[selected_index]
	dni_information.display_person_dni(selected_person["dni"])
	update_person_image()
	
func update_person_image():
	if selected_index != -1 and persons.size() > 0:
		var selected_person = persons[selected_index]
		$CharacterSprite.texture = selected_person["image"]
		$CharacterSprite.visible = true
	else:
		$CharacterSprite.visible = false
		print("No valid person or list is empty.")
	
func _on_accept_button_pressed():
	select_random_person()
	if selected_index != -1:
		var selected_person = persons[selected_index]
		dni_information.display_person_dni(selected_person["dni"])

func _on_reject_button_pressed():
	select_random_person()
	if selected_index != -1:
		var selected_person = persons[selected_index]
		dni_information.display_person_dni(selected_person["dni"])
		
func change_persons_list(new_list):
	persons = new_list
	select_random_person()

func _on_change_to_vector_button_pressed():
	change_persons_list(vector_persons)


func _on_change_to_pixel_art_button_pressed():
	change_persons_list(pixel_art_persons)
