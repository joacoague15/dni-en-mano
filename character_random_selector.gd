extends Node2D

@onready var dni_information = $DNIInformation
@onready var correct_label = $CorrectCharacterLabel
@onready var incorrect_label = $IncorrectCharacterLabel
@onready var result_label = $ResultLabel

var persons = [
	{"name": "Camila", "image": preload("res://characterImages/camila.webp"), "problem": "due_date", "dni": {"name": "Camila Gutierrez", "born_date": "15-01-1990", "due_date": "10-05-2024", "document_photo": preload("res://characterImages/camila.webp")}},
	{"name": "Franco", "image": preload("res://characterImages/franco.webp"), "problem": null, "dni": {"name": "Franco Perez", "born_date": "10-03-1997", "due_date": "20-02-2025", "document_photo": preload("res://characterImages/franco.webp")}},
	{"name": "Victoria", "image": preload("res://characterImages/victoria.webp"), "problem": null, "dni": {"name": "Victoria Ramirez", "born_date": "25-07-1995", "due_date": "01-12-2028", "document_photo": preload("res://characterImages/victoria.webp")}},
	{"name": "Juan", "image": preload("res://characterImages/juan.webp"), "problem": "born_date", "dni": {"name": "Juan Ramirez", "born_date": "25-07-2008", "due_date": "05-05-2030", "document_photo": preload("res://characterImages/juan.webp")}},
	{"name": "Lucas", "image": preload("res://characterImages/lucas.webp"), "problem": "due_date", "dni": {"name": "Lucas Vitz", "born_date": "13-11-1997", "due_date": "14-03-2024", "document_photo": preload("res://characterImages/lucas.webp")}},
	{"name": "Rosa", "image": preload("res://characterImages/rosa.webp"), "problem": null, "dni": {"name": "Rosa Yung", "born_date": "20-07-1995", "due_date": "10-10-2026", "document_photo": preload("res://characterImages/rosa.webp")}}
]

var current_videogame_date = "23-08-2024"

var selected_index = -1
var previous_index = -1

var correct_characters = 0
var incorrect_characters = 0

func _ready():
	select_random_person()
	update_correct_incorrect_count()
	
func select_random_person():
	if persons.size() == 0:
		print("No more persons available.")
		$CharacterSprite.visible = false
		return
		
	while selected_index == previous_index:
		selected_index = randi() % persons.size()
		
	previous_index = selected_index
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
		
func update_correct_incorrect_count():
	correct_label.text = "Aciertos: %d" % correct_characters
	incorrect_label.text = "Equivocaciones: %d" % incorrect_characters
	
func update_result_message(result_message):
	result_label.text = result_message
	
func _on_accept_button_pressed():
	var selected_person = persons[selected_index]	
	handle_accept_reject(selected_person["problem"], true)
	dni_information.display_person_dni(selected_person["dni"])	
	select_random_person()

func _on_reject_button_pressed():
	var selected_person = persons[selected_index]	
	handle_accept_reject(selected_person["problem"], false)
	dni_information.display_person_dni(selected_person["dni"])
	select_random_person()
		
func handle_accept_reject(problem, wasAccepted):
	var result_message = ""
	if problem in ["due_date", "born_date"]:
		if wasAccepted:
			result_message = "El DNI estaba vencido" if problem == "due_date" else "El personaje no era mayor de edad"
			incorrect_characters += 1
		else:
			result_message = "Correcto!"
			correct_characters += 1
	else: 
		if not problem and not wasAccepted:
			result_message = "El DNI estaba correcto"
			incorrect_characters += 1
		elif not problem and wasAccepted:
			result_message = "Bien!"
			correct_characters += 1
	update_correct_incorrect_count()
	update_result_message(result_message)
		
		
