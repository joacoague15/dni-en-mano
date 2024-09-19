extends Node2D

@onready var dni_information = $DNIInformation
@onready var result_label = $ResultLabel
@onready var rules_label = $Phone/RulesLabel
@onready var rules_label_animation_player = $Phone/RulesLabel/RulesAnimationPlayer
@onready var show_rules_button = $ShowRulesButton
@onready var character_sprite = $CharacterSprite
@onready var character_animation_player = $CharacterSprite/AnimationPlayer
@onready var dni_animation_player = $DNIInformation/DNIAnimationPlayer
@onready var result_animation_player = $ResultScreen/ResultAnimationPlayer

@onready var accept_button = $AcceptButton
@onready var reject_button = $RejectButton
@onready var background_music = $BackgroundMusicPlayer

@export var hover_color: Color = Color(1, 0.5, 0.5)  # light red
@export var normal_color: Color = Color(1, 1, 1)      # white

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

var custom_cursor = load("res://characterImages/hand.png")
var thumb_up_cursor= load("res://characterImages/thumb_up.png")
var thumb_down_cursor= load("res://characterImages/thumb_down.png")
var current_videogame_date = "23-08-2024"

var selected_index = -1
var previous_index = -1
var correct_characters = 0
var incorrect_characters = []
var selected_person

var rules_visible = false

var check_interval = 0.1  # Check every 0.1 seconds
var time_since_last_check = 0.0

func _ready():
	background_music.play()
	Input.set_custom_mouse_cursor(custom_cursor, 0, Vector2(64, 64))
	apply_rules()
	accept_button.visible = false
	reject_button.visible = false
	next_person()
	
func _process(delta):
	time_since_last_check += delta
	if time_since_last_check >= check_interval:
		time_since_last_check = 0.0
		
func new_selected_person():
	while selected_index == previous_index:
		selected_index = randi() % persons.size()
		
	previous_index = selected_index
	return persons[selected_index]
	
func next_person():
	await get_tree().create_timer(1.5).timeout
	selected_person = new_selected_person()
	character_animation_player.play("character_appear")	
	character_sprite.position = Vector2(-500, 0)	
	character_sprite.texture = selected_person["image"]
		
func _on_accept_button_pressed():
	$DialogueControl.hide_dialogue()
	handle_accept_reject(selected_person["problem"], true)

func _on_reject_button_pressed():
	$DialogueControl.hide_dialogue()
	handle_accept_reject(selected_person["problem"], false)
		
func handle_accept_reject(problem, wasAccepted):
	var correct_choice = false
	accept_button.visible = false
	reject_button.visible = false
	dni_animation_player.play("dni_disappear")
	if problem in ["due_date", "born_date"]:
		if wasAccepted:
			incorrect_characters.append(problem)
		else:
			correct_characters += 1
			correct_choice = true
	else: 
		if not problem and not wasAccepted:
			incorrect_characters.append(problem)
		elif not problem and wasAccepted:
			correct_characters += 1
			correct_choice = true
	handle_character_enter_or_not_anim(wasAccepted)
		
func apply_rules():
	var rules = [
		"Entrada cierra 03:00",
		"Solo mayores de edad (+18)",
		"El documento debe ser valido"
	]

	var rules_text = ""
	for rule in rules:
		rules_text += rule + "\n"
	
	rules_label.text = rules_text
		
func _on_show_rules_button_pressed():
	if not rules_label_animation_player.is_playing():
		var animation = "rules_appear" if not rules_visible else "rules_disappear"
		rules_label_animation_player.play(animation)
		rules_visible = !rules_visible

func _on_animation_player_animation_finished(animation_name):
	if animation_name == "character_appear":
		character_animation_player.play("character_idle")
	if animation_name == "character_enter" or animation_name == "character_no_enter":
		background_music.set_bus("New Bus")
		background_music.set_volume_db(0)
		next_person()
		
func _on_animation_player_animation_started(animation_name):
	if animation_name == "character_idle":
		$DialogueControl.show_dialogue()
		dni_information.display_person_dni(selected_person["dni"])
		dni_animation_player.play("dni_appear")

func handle_character_enter_or_not_anim(wasAccepted):
	if wasAccepted:
		character_animation_player.play("character_enter")
		background_music.set_bus("Master")
		background_music.set_volume_db(background_music.get_volume_db() + 10)
	else:
		character_animation_player.play("character_no_enter")

func _on_dni_animation_player_animation_finished(animation_name):
	if animation_name == "dni_appear":
		accept_button.visible = true
		reject_button.visible = true
		
func _on_result_animation_player_animation_finished(animation_name):
	if animation_name == "show_results":
		result_animation_player.play("show_labels")

func _on_accept_button_mouse_entered():
	Input.set_custom_mouse_cursor(thumb_up_cursor, 0, Vector2(64, 64))

func _on_reject_button_mouse_entered():
	modulate = hover_color
	Input.set_custom_mouse_cursor(thumb_down_cursor, 0, Vector2(64, 64))

func _on_accept_button_mouse_exited():
	modulate = normal_color
	Input.set_custom_mouse_cursor(custom_cursor, 0, Vector2(64, 64))

func _on_reject_button_mouse_exited():
	modulate = normal_color
	Input.set_custom_mouse_cursor(custom_cursor, 0, Vector2(64, 64))
