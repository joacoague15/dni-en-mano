extends Node2D

@onready var dni_information = $DNIInformation
@onready var rules_label = $Phone/RulesLabel
@onready var rules_label_animation_player = $Phone/RulesAnimationPlayer
@onready var show_rules_button = $ShowRulesButton
@onready var character_sprite = $CharacterSprite
@onready var character_animation_player = $CharacterSprite/AnimationPlayer
@onready var dni_animation_player = $DNIInformation/DNIAnimationPlayer
@onready var win_or_loose_label = $ResultScreen/WinOrLooseLabel
@onready var result_animation_player = $ResultScreen/ResultAnimationPlayer
@onready var total_characters_count = $ResultScreen/TotalCharactersCount
@onready var correct_characters_count = $ResultScreen/CorrectCharactersCount
@onready var incorrect_characters_count = $ResultScreen/IncorrectCharactersCount
@onready var energy_label = $Phone/EnergyLabel
@onready var strikes_label = $Phone/StrikesLabel
@onready var correct_character_label = $Phone/CorrectCharactersLabel

@onready var phone_sprite = $ShowRulesButton/phone

@onready var win_or_loose_screen = $ResultScreen/WinOrLooseImage

@onready var wrong_choice_notification_label = $WrongChoiceNotificationLabel

@onready var scanning_progress_bar = $ScanningProgressBar
@onready var scanning_button = $ScanningButton
@onready var activate_scan_button = $ActivateScanButton

@onready var accept_button = $AcceptButton
@onready var reject_button = $RejectButton
@onready var background_music = $BackgroundMusicPlayer

var persons = [
	{"name": "Camila", "image": preload("res://characterImages/characters/character1.png"), "problem": null, "dni": {"name": "Camila Gutierrez", "born_date": "15/03/2003", "due_date": "10/05/2025", "document_photo": preload("res://characterImages/portraits/portrait1.png")}},
	{"name": "Victoria", "image": preload("res://characterImages/characters/character2.png"), "problem": null, "dni": {"name": "Victoria Ramirez", "born_date": "10/03/2002", "due_date": "20/12/2025", "document_photo": preload("res://characterImages/portraits/portrait2.png")}},
	{"name": "Romina", "image": preload("res://characterImages/characters/character3.png"), "problem": "due_date", "dni": {"name": "Romina Gomez", "born_date": "25/07/2004", "due_date": "10/07/2024", "document_photo": preload("res://characterImages/portraits/portrait3.png")}},
	{"name": "Juan", "image": preload("res://characterImages/characters/character4.png"), "problem": "born_date", "dni": {"name": "Juan Ramirez", "born_date": "25/07/2008", "due_date": "05/05/2026", "document_photo": preload("res://characterImages/portraits/portrait4.png")}},
	{"name": "Valentin", "image": preload("res://characterImages/characters/character5.png"), "problem": null, "dni": {"name": "Valentin Gomez", "born_date": "01/04/1999", "due_date": "10/03/2025", "document_photo": preload("res://characterImages/portraits/portrait5.png")}},
	{"name": "Luciana", "image": preload("res://characterImages/characters/character6.png"), "problem": "wrong_portrait", "dni": {"name": "Luciana Herrera", "born_date": "24/11/2005", "due_date": "03/07/2027", "document_photo": preload("res://characterImages/portraits/portrait6.png")}},
	{"name": "Juliana", "image": preload("res://characterImages/characters/character7.png"), "problem": null, "dni": {"name": "Juliana Rojas", "born_date": "10/06/2003", "due_date": "09/12/2025", "document_photo": preload("res://characterImages/portraits/portrait7.png")}},
	{"name": "Micaela", "image": preload("res://characterImages/characters/character8.png"), "problem": null, "dni": {"name": "Micaela Fernandez", "born_date": "14/08/2000", "due_date": "02/12/2024", "document_photo": preload("res://characterImages/portraits/portrait8.png")}},
]

var win_screen = preload("res://characterImages/win_screen.jpg")
var loose_screen = preload("res://characterImages/LooseImage.jpg")

var current_videogame_date = "04-10-2024"

var selected_index = -1
var correct_characters
var incorrect_characters
var selected_person

var rules_visible = false

var check_interval = 0.1
var time_since_last_check = 0.0

var energy = 100
var PERMITED_STRIKES = 2
var correct_character_needed = 1
var strikes = 0

var is_holding = false
var progress = 0.0
var progress_time = 1.5

var	is_scan_activated = false

func _ready():
	scanning_progress_bar.value = 0
	correct_characters = 0
	activate_scan_button.disabled = true
	incorrect_characters = []
	background_music.play()
	energy_label.text = "Energia: " + str(energy)
	strikes_label.text = "Strikes: " + str(strikes)
	correct_character_label.text = "Objetivo : " + str(correct_characters) + " / " + str(correct_character_needed)
	apply_rules()
	accept_button.visible = false
	reject_button.visible = false
	next_person()
	
func _process(delta):
	time_since_last_check += delta
	if time_since_last_check >= check_interval:
		time_since_last_check = 0.0
		
	if is_scan_activated:
		progress += delta / progress_time
		if progress >= 1.0:
			progress = 1.0
			scanning_progress_bar.visible = false
			activate_scan_button.disabled = true
			is_scan_activated = false
			energy += 3
			if energy > 10:
				energy = 10
			energy_label.text = "Energia: " + str(energy)
	else:
		if progress > 0:
			progress = 0

	scanning_progress_bar.value = progress * scanning_progress_bar.max_value
		
func new_selected_person():
	selected_index += 1
	return persons[selected_index]
	
func next_person():
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
	handle_energy()
	dni_animation_player.play("dni_disappear")
	if problem in ["due_date", "born_date", "wrong_portrait"]:
		if wasAccepted:
			incorrect_characters.append(problem)
			handle_strikes()
			handle_incorrect_choice_notification(problem)
		else:
			correct_choice = true
			handle_amount_correct_characters()
	else: 
		if not problem and not wasAccepted:
			incorrect_characters.append(problem)
			handle_strikes()
			handle_incorrect_choice_notification(problem)
		elif not problem and wasAccepted:
			correct_choice = true
			handle_amount_correct_characters()
	handle_character_enter_or_not_anim(wasAccepted)
	
func handle_energy():
	if energy <= 1:
		end_level()
	energy -= 1
	energy_label.text = "Energia: " + str(energy)
	
func handle_strikes():
	if strikes < PERMITED_STRIKES:
		strikes += 1
		strikes_label.text = "Strikes: " + str(strikes)
	else:
		end_level()
		
func handle_incorrect_choice_notification(problem):
	var message = ""
	match problem:
		"due_date":
			message = "DNI caducado"
		"born_date":
			message = "No era mayor de edad"
		"wrong_portrait":
			message = "Lo retrato no era correcto"
		_:
			message = "No habia nada de malo con el cliente"

	wrong_choice_notification_label.text = "" 
	await type_text(message)  
	
func type_text(text_to_type):
	var typing_speed = 0.05
	for char in text_to_type:
		wrong_choice_notification_label.text += char
		await get_tree().create_timer(typing_speed).timeout
	
		
func handle_amount_correct_characters():
	correct_characters += 1
	correct_character_label.text = "Objetivo : " + str(correct_characters) + " / " + str(correct_character_needed)
	if correct_characters >= correct_character_needed:
		fill_result_details()
		result_animation_player.play("show_results")
		
func end_level():
	fill_result_details()
	result_animation_player.play("show_results")
		
func apply_rules():
	var rules = [
		"Solo mayores de edad (+18)",
		"El DNI debe estar en regla",
		"Entrada cierra 03:00hs"
	]

	var rules_text = "REGLAS" + "\n"
	for rule in rules:
		rules_text += rule + "\n"
	
	rules_label.text = rules_text
	
func fill_result_details():
	if strikes >= PERMITED_STRIKES or correct_characters < correct_character_needed:
		win_or_loose_label.text = "PERDISTE"
		win_or_loose_label.modulate = Color(1, 0, 0)
		win_or_loose_screen.texture = loose_screen
	else:
		win_or_loose_screen.texture = win_screen
		win_or_loose_label.text = "GANASTE"
		win_or_loose_label.modulate = Color(0, 1, 0)
	total_characters_count.text = "Clientes totales: " + str(correct_characters + incorrect_characters.size())
	correct_characters_count.text = "Pasaron correctamente: " + str(correct_characters)
	incorrect_characters_count.text = "Errores: " + str(incorrect_characters.size())
		
func _on_show_rules_button_pressed():
	if not rules_label_animation_player.is_playing():
		var animation = "rules_appear" if not rules_visible else "rules_disappear"
		rules_label_animation_player.play(animation)
		rules_visible = !rules_visible

func _on_animation_player_animation_finished(animation_name):
	if animation_name == "character_appear":
		character_animation_player.play("character_idle")
		activate_scan_button.disabled = false
		scanning_progress_bar.visible = true
	if animation_name == "character_enter" or animation_name == "character_no_enter":
		activate_scan_button.disabled = true
		background_music.set_bus("New Bus")
		background_music.set_volume_db(0)
		next_person()
		
func _on_animation_player_animation_started(animation_name):
	if animation_name == "character_idle":
		$DialogueControl.show_dialogue()
		dni_information.display_person_dni(selected_person["dni"])
		dni_animation_player.play("dni_appear")
	if animation_name == "character_enter" or animation_name == "character_no_enter":
		activate_scan_button.disabled = true
		scanning_progress_bar.visible = false

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

func _on_activate_scan_button_pressed():
	is_scan_activated = !is_scan_activated	

func _on_show_rules_button_mouse_entered():
	phone_sprite.modulate = Color.GRAY
	phone_sprite.scale = Vector2(0.6, 0.6)

func _on_show_rules_button_mouse_exited():
	phone_sprite.modulate = Color.WHITE
	phone_sprite.scale = Vector2(0.55, 0.55)

func _on_show_rules_button_button_down():
	phone_sprite.modulate = Color.DARK_GRAY
	phone_sprite.scale = Vector2(0.52, 0.52)

func _on_show_rules_button_button_up():
	phone_sprite.modulate = Color.WHITE	
	phone_sprite.scale = Vector2(0.55, 0.55)

func _on_accept_button_mouse_entered():
	accept_button.modulate = Color.LIGHT_GREEN

func _on_accept_button_mouse_exited():
	accept_button.modulate = Color.WHITE

func _on_reject_button_mouse_entered():
	reject_button.modulate = Color.LIGHT_CORAL

func _on_reject_button_mouse_exited():
	reject_button.modulate = Color.WHITE

func _on_next_level_button_pressed():
	pass
