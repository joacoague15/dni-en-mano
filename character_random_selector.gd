extends Node2D

@onready var dni_information = $DNIInformation
@onready var correct_label = $CorrectCharacterLabel
@onready var incorrect_label = $IncorrectCharacterLabel
@onready var result_label = $ResultLabel
@onready var rules_label = $RulesLabel
@onready var show_rules_button = $ShowRulesButton
@onready var vertical_bar = $VerticalBar
@onready var character_animation_player = $CharacterSprite/AnimationPlayer
@onready var dni_animation_player = $DNIInformation/DNIAnimationPlayer

var persons = [
	{"name": "Camila", "image": preload("res://characterImages/character1.png"), "problem": "due_date", "dni": {"name": "Camila Gutierrez", "born_date": "15/01/1990", "due_date": "10/05/2024", "document_photo": preload("res://characterImages/character1.png")}},
	{"name": "Franco", "image": preload("res://characterImages/character1.png"), "problem": null, "dni": {"name": "Franco Perez", "born_date": "10/03/1997", "due_date": "20/02/2025", "document_photo": preload("res://characterImages/character1.png")}},
	{"name": "Victoria", "image": preload("res://characterImages/character1.png"), "problem": null, "dni": {"name": "Victoria Ramirez", "born_date": "25/07/1995", "due_date": "01/12/2028", "document_photo": preload("res://characterImages/character1.png")}},
	{"name": "Juan", "image": preload("res://characterImages/character1.png"), "problem": "born_date", "dni": {"name": "Juan Ramirez", "born_date": "25/07/2008", "due_date": "05/05/2030", "document_photo": preload("res://characterImages/character1.png")}},
	{"name": "Lucas", "image": preload("res://characterImages/character1.png"), "problem": "due_date", "dni": {"name": "Lucas Vitz", "born_date": "13/11/1997", "due_date": "14/03/2024", "document_photo": preload("res://characterImages/character1.png")}},
	{"name": "Rosa", "image": preload("res://characterImages/character2.png"), "problem": null, "dni": {"name": "Rosa Yung", "born_date": "20/07/1995", "due_date": "10/10/2026", "document_photo": preload("res://characterImages/character2.png")}},
	{"name": "Claudio", "image": preload("res://characterImages/character2.png"), "problem": null, "dni": {"name": "Claudio Fernandez", "born_date": "10/06/1998", "due_date": "10/12/2024", "document_photo": preload("res://characterImages/character2.png")}},
	{"name": "Gerardo", "image": preload("res://characterImages/character2.png"), "problem": null, "dni": {"name": "Gerardo Gonzalez", "born_date": "01/05/1999", "due_date": "10/01/2025", "document_photo": preload("res://characterImages/character2.png")}},
	{"name": "Romina", "image": preload("res://characterImages/character2.png"), "problem": "due_date", "dni": {"name": "Romina Gomez", "born_date": "01/05/1996", "due_date": "10/07/2024", "document_photo": preload("res://characterImages/character2.png")}},
	{"name": "Valentina", "image": preload("res://characterImages/character2.png"), "problem": null, "dni": {"name": "Valentina Gomez", "born_date": "01/05/1996", "due_date": "10/07/2025", "document_photo": preload("res://characterImages/character2.png")}}
]

var current_videogame_date = "23-08-2024"

var selected_index = -1
var previous_index = -1

var correct_characters = 0
var incorrect_characters = 0

func _ready():
	select_random_person()
	update_correct_incorrect_count()
	apply_rules()
	vertical_bar.value = 0
	
func select_random_person():
	if persons.size() == 0:
		print("No more persons available. Result screen")
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
		if character_animation_player.is_playing():
			return
			
		if not $CharacterSprite.visible:
			_show_and_slide_in()
	else:
		$CharacterSprite.visible = false
		
func _show_and_slide_in():
	$CharacterSprite.visible = true
		
func update_correct_incorrect_count():
	correct_label.text = "Aciertos: %d" % correct_characters
	incorrect_label.text = "Equivocaciones: %d" % incorrect_characters
	
func update_result_message(result_message):
	result_label.text = result_message
	
func _on_accept_button_pressed():
	if selected_index != -1 and selected_index < persons.size():
		var selected_person = persons[selected_index]	
		handle_accept_reject(selected_person["problem"], true)
		dni_information.display_person_dni(selected_person["dni"])	
		select_random_person()

func _on_reject_button_pressed():
	if selected_index != -1 and selected_index < persons.size():
		var selected_person = persons[selected_index]	
		handle_accept_reject(selected_person["problem"], false)
		dni_information.display_person_dni(selected_person["dni"])
		select_random_person()
		
func handle_accept_reject(problem, wasAccepted):
	var correct_choice = false
	var result_message = ""
	if problem in ["due_date", "born_date"]:
		if wasAccepted:
			result_message = "El DNI estaba vencido" if problem == "due_date" else "El personaje no era mayor de edad"
			incorrect_characters += 1
		else:
			result_message = "Correcto!"
			correct_characters += 1
			correct_choice = true
	else: 
		if not problem and not wasAccepted:
			result_message = "El DNI estaba correcto"
			incorrect_characters += 1
		elif not problem and wasAccepted:
			result_message = "Bien!"
			correct_characters += 1
			correct_choice = true
	update_correct_incorrect_count()
	update_result_message(result_message)
	handle_vertical_bar_change(correct_choice)
		
func apply_rules():
	var rules = [
		"Solo mayores de edad +18",
		"El documento ser valido"
	]

	var rules_text = ""
	for rule in rules:
		rules_text += rule + "\n"
	
	rules_label.text = rules_text
		
func _on_show_rules_button_pressed():
	rules_label.visible = not rules_label.visible
	if rules_label.visible:
		show_rules_button.text = "Ocultar"
	else:
		show_rules_button.text = "Mostrar reglas"
		
func handle_vertical_bar_change(correct_choice):
	if correct_choice:
		vertical_bar.value += 10
	else:
		vertical_bar.value -= 10
