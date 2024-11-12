extends Node2D

# --- UI ELEMENTS ---
# Phone and Rules UI
@onready var phone = $Phone
@onready var rules_label = $Phone/RulesLabel
@onready var rules_label_animation_player = $Phone/RulesAnimationPlayer
@onready var show_rules_button = $Phone/ShowRulesButton

# Countdown Timer and Labels
@onready var countdown_label = $CountdownNode/CountdownLabel
@onready var countdown_label_animator = $CountdownNode/CountdownAnimationPlayer
@onready var countdown_timer = $CountdownNode/CountdownTimer

# Result Screen
@onready var result_screen = $ResultScreen
@onready var win_or_loose_label = $ResultScreen/WinOrLooseLabel
@onready var result_animation_player = $ResultScreen/ResultAnimationPlayer
@onready var total_characters_count = $ResultScreen/TotalCharactersCount
@onready var correct_characters_count = $ResultScreen/CorrectCharactersCount
@onready var incorrect_characters_count = $ResultScreen/IncorrectCharactersCount
@onready var next_level_button = $ResultScreen/NextLevelButton
@onready var next_level_button_label = $ResultScreen/NextLevelButton/Label
@onready var win_or_loose_screen = $ResultScreen/WinOrLooseImage
@onready var new_rule_notification = $ResultScreen/NewRuleNotification

# --- CHARACTER AND DIALOGUE ---
# Character and Animation UI
@onready var character_sprite = $CharacterSprite
@onready var character_animation_player = $CharacterSprite/AnimationPlayer

# Player Dialogue
@onready var player_dialogue_label = $DialogueControl/CharacterDialogueLabel

# Wrong Choice Notification
@onready var wrong_choice_notification_label = $WrongChoiceNotificationLabel

# Accept and Reject Buttons
@onready var accept_button = $AcceptButton
@onready var reject_button = $RejectButton

# --- DNI AND CREDENTIALS ---
# DNI Information Display
@onready var dni_animation_player = $DNIInformation/DNIAnimationPlayer
@onready var name_label = $DNIInformation/NameLabel
@onready var born_date_label = $DNIInformation/BornDateLabel
@onready var due_date_label = $DNIInformation/DueDateLabel
@onready var portrait_sprite = $DNIInformation/PortraitSprite

# Current Date
@onready var current_date = $CurrentDateLabel

# Random Credential Display
@onready var random_credential = $RandomCredential
@onready var random_credential_animation_player = $RandomCredential/RandomCredentialAnimationPlayer

# Ticket Information
@onready var ticket_information = $TicketInformation
@onready var ticket_animation_player = $TicketInformation/TicketAnimationPlayer
@onready var ticket_logo = $TicketInformation/TicketLogo

# --- MENU ELEMENTS ---
@onready var menu = $Menu
@onready var play_button = $Menu/Play
@onready var how_to_play_button = $Menu/HowToPlay
@onready var menu_audio_stream_player = $Menu/MenuAudioStreamPlayer
@onready var menu_animation_player = $Menu/MenuAnimationPlayer

# --- CINEMATIC ---
@onready var main_cinematic = $MainCinematic
@onready var cinematic_audio_stream_player = $MainCinematic/CinematicAudioStreamPlayer
@onready var cinematic_animation_player = $MainCinematic/CinematicAnimationPlayer

# --- TUTORIAL ELEMENTS ---
@onready var tutorial_panel = $Menu/TutorialPanel
@onready var tutorial_display = $Menu/TutorialPanel/TutorialDisplay

# --- LEVEL START/END UI ---
# First Level Start Screen
@onready var start_first_level_screen = $StartFirstLevelScreen
@onready var start_first_level_button = $StartFirstLevelScreen/PlayFirstLevelButton
@onready var first_level_animation_player = $StartFirstLevelScreen/FirstLevelAnimationPlayer
@onready var first_rules_notification = $StartFirstLevelScreen/FirstRulesNotification

# End Screen
@onready var end_screen = $EndScreen

# --- AUDIO ---
@onready var background_music = $BackgroundMusicPlayer

# --- ICONS AND TEXTURES ---
@onready var thumb_down = preload("res://images/thumb_down.png")
@onready var thumb_down_pressed = preload("res://images/thumb_down_pressed.png")
@onready var thumb_up = preload("res://images/thumb_up.png")
@onready var thumb_up_pressed = preload("res://images/thumb_up_pressed.png")
@onready var full_heart_icon = preload("res://images/full_heart.png")
@onready var empty_heart_icon = preload("res://images/empty_heart.png")
@onready var sube = preload("res://images/sube.png")
@onready var ioma = preload("res://images/ioma.png")
@onready var pitusas = preload("res://images/pitusas.png")
@onready var phone_display_level_1 = preload("res://images/phone_display_level_1.png")
@onready var phone_display_level_2 = preload("res://images/phone_display_level_2.png")

# --- HEART ICONS ---
# Heart icons for lives
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var correct_character_label = $CorrectCharactersLabel

var persons_first_level = [
	{"name": "Camila", "image": preload("res://images/characters/character1.png"), "problem": null, "dni": {"name": "Camila Gutierrez", "born_date": "15/03/2003", "due_date": "10/05/2025", "document_photo": preload("res://images/portraits/portrait1.png")}},
	{"name": "Romina", "image": preload("res://images/characters/character3.png"), "problem": "due_date", "dni": {"name": "Romina Gomez", "born_date": "25/07/2004", "due_date": "10/07/2024", "document_photo": preload("res://images/portraits/portrait3.png")}},
	{"name": "Juan", "image": preload("res://images/characters/character4.png"), "problem": "born_date", "dni": {"name": "Juan Ramirez", "born_date": "25/07/2008", "due_date": "05/05/2026", "document_photo": preload("res://images/portraits/portrait4.png")}},
	{"name": "Valentin", "image": preload("res://images/characters/character5.png"), "problem": null, "dni": {"name": "Valentin Gomez", "born_date": "01/04/1999", "due_date": "10/03/2025", "document_photo": preload("res://images/portraits/portrait5.png")}},
	{"name": "Luciana", "image": preload("res://images/characters/character6.png"), "problem": "wrong_portrait", "dni": {"name": "Luciana Herrera", "born_date": "24/11/2005", "due_date": "03/07/2027", "document_photo": preload("res://images/portraits/portrait6.png")}},
	{"name": "Juliana", "image": preload("res://images/characters/character7.png"), "problem": null, "dni": {"name": "Juliana Rojas", "born_date": "10/06/2003", "due_date": "09/12/2025", "document_photo": preload("res://images/portraits/portrait7.png")}},
	{"name": "Micaela", "image": preload("res://images/characters/character8.png"), "problem": null, "dni": {"name": "Micaela Fernandez", "born_date": "14/08/2000", "due_date": "02/12/2024", "document_photo": preload("res://images/portraits/portrait8.png")}},
	{"name": "Santiago", "image": preload("res://images/characters/character9.png"), "problem": "no_dni", "dni": {"name": "Santiago Acosta", "born_date": "18/11/2000", "due_date": "05/04/2025", "document_photo": preload("res://images/portraits/portrait9.png")}},
	{"name": "Facundo", "image": preload("res://images/characters/character10.png"), "problem": null, "dni": {"name": "Facundo Navarro", "born_date": "12/12/2002", "due_date": "20/04/2025", "document_photo": preload("res://images/portraits/portrait10.png")}},
	{"name": "Martín", "image": preload("res://images/characters/character11.png"), "problem": "born_date", "dni": {"name": "Martín Díaz", "born_date": "15/03/2009", "due_date": "13/09/2026", "document_photo": preload("res://images/portraits/portrait11.png")}},
	{"name": "Tomás", "image": preload("res://images/characters/character12.png"), "problem": null, "dni": {"name": "Tomás Sánchez", "born_date": "01/01/2001", "due_date": "20/10/2025", "document_photo": preload("res://images/portraits/portrait12.png")}},
]

var persons_second_level = [
	{"name": "Luciano", "image": preload("res://images/characters/character13.png"), "problem": null, "dni": {"name": "Luciano Ponce", "born_date": "15/03/2003", "due_date": "10/05/2025", "document_photo": preload("res://images/portraits/portrait13.png")}},
	{"name": "Santiago", "image": preload("res://images/characters/character14.png"), "problem": null, "dni": {"name": "Santiago Escobar", "born_date": "10/03/2002", "due_date": "20/12/2025", "document_photo": preload("res://images/portraits/portrait14.png")}},
	{"name": "Jorge", "image": preload("res://images/characters/character18.png"), "problem": "due_date", "dni": {"name": "Jorge Jorji", "born_date": "01/04/1979", "due_date": "10/03/1998", "document_photo": preload("res://images/portraits/portrait18.png")}},
	{"name": "Martín", "image": preload("res://images/characters/character11.png"), "problem": "born_date", "dni": {"name": "Martín Díaz", "born_date": "15/03/2009", "due_date": "13/09/2026", "document_photo": preload("res://images/portraits/portrait11.png")}},
	{"name": "Micaela", "image": preload("res://images/characters/character8.png"), "problem": "no_ticket", "dni": {"name": "Micaela Fernandez", "born_date": "14/08/2000", "due_date": "02/12/2024", "document_photo": preload("res://images/portraits/portrait8.png")}},
	{"name": "Victoria", "image": preload("res://images/characters/character2.png"), "problem": null, "dni": {"name": "Victoria Ramirez", "born_date": "10/03/2002", "due_date": "20/12/2025", "document_photo": preload("res://images/portraits/portrait2.png")}},
	{"name": "Franco", "image": preload("res://images/characters/character15.png"), "problem": "due_date", "dni": {"name": "Franco Navarro", "born_date": "25/07/2004", "due_date": "11/07/2024", "document_photo": preload("res://images/portraits/portrait15.png")}},
	{"name": "Juan", "image": preload("res://images/characters/character16.png"), "problem": null, "dni": {"name": "Juan Aguirre", "born_date": "26/10/2004", "due_date": "05/05/2026", "document_photo": preload("res://images/portraits/portrait16.png")}},
	{"name": "Juliana", "image": preload("res://images/characters/character7.png"), "problem": null, "dni": {"name": "Juliana Rojas", "born_date": "10/06/2003", "due_date": "09/12/2025", "document_photo": preload("res://images/portraits/portrait7.png")}},
	{"name": "Carlos", "image": preload("res://images/characters/character17.png"), "problem": "no_dni", "dni": {"name": "Carlos Herrera", "born_date": "01/04/1999", "due_date": "10/03/2025", "document_photo": preload("res://images/portraits/portrait17.png")}},
]

var persons_third_level = [
	{"name": "Valentin", "image": preload("res://images/characters/character5.png"), "problem": "no_ticket_logo", "dni": {"name": "Valentin Gomez", "born_date": "01/04/1999", "due_date": "10/03/2025", "document_photo": preload("res://images/portraits/portrait5.png")}},
	{"name": "Juliana", "image": preload("res://images/characters/character7.png"), "problem": null, "dni": {"name": "Juliana Rojas", "born_date": "10/06/2003", "due_date": "09/12/2025", "document_photo": preload("res://images/portraits/portrait7.png")}},
	{"name": "Juan", "image": preload("res://images/characters/character4.png"), "problem": "born_date", "dni": {"name": "Juan Ramirez", "born_date": "02/12/2009", "due_date": "05/05/2026", "document_photo": preload("res://images/portraits/portrait4.png")}},
	{"name": "Micaela", "image": preload("res://images/characters/character8.png"), "problem": "no_ticket_logo", "dni": {"name": "Micaela Fernandez", "born_date": "14/08/2000", "due_date": "02/12/2024", "document_photo": preload("res://images/portraits/portrait8.png")}},
	{"name": "Tomás", "image": preload("res://images/characters/character12.png"), "problem": null, "dni": {"name": "Tomás Sánchez", "born_date": "01/01/2001", "due_date": "20/10/2025", "document_photo": preload("res://images/portraits/portrait12.png")}},
	{"name": "Jorge", "image": preload("res://images/characters/character18.png"), "problem": "no_dni", "dni": {"name": "Jorge Jorji", "born_date": "01/04/1999", "due_date": "10/03/1998", "document_photo": preload("res://images/portraits/portrait18.png")}},
	{"name": "Victoria", "image": preload("res://images/characters/character2.png"), "problem": null, "dni": {"name": "Victoria Ramirez", "born_date": "10/03/2002", "due_date": "20/12/2025", "document_photo": preload("res://images/portraits/portrait2.png")}},
	{"name": "Franco", "image": preload("res://images/characters/character15.png"), "problem": "due_date", "dni": {"name": "Franco Navarro", "born_date": "25/07/2004", "due_date": "26/08/2024", "document_photo": preload("res://images/portraits/portrait15.png")}},
	{"name": "Juan", "image": preload("res://images/characters/character16.png"), "problem": null, "dni": {"name": "Juan Aguirre", "born_date": "26/10/2004", "due_date": "05/05/2026", "document_photo": preload("res://images/portraits/portrait16.png")}},
	{"name": "Juliana", "image": preload("res://images/characters/character7.png"), "problem": null, "dni": {"name": "Juliana Rojas", "born_date": "10/06/2003", "due_date": "09/12/2025", "document_photo": preload("res://images/portraits/portrait7.png")}},
	{"name": "Carlos", "image": preload("res://images/characters/character17.png"), "problem": "no_ticket", "dni": {"name": "Carlos Herrera", "born_date": "01/04/1999", "due_date": "10/03/2025", "document_photo": preload("res://images/portraits/portrait17.png")}},
]

var dialogues = [
	"Buenas",
	"Buenas buenas",
	"¿Todo bien?",
	"Hola, ¿qué tal?",
	"¿Qué tal?",
	"Buenas, ¿cómo va?",
	"Está todo en regla. ¿Me dejás pasar?",
	"¿Todo bien por acá? ¿puedo entrar?",
	"Está todo bien, ¿me das el OK?",
	"Dale, ya me conocen acá ¿Me dejás?",
	"¡Sería un crimen no dejarme entrar!",
	"¡La pista me necesita!",
	"¡Apurate que me están esperando!",
	"No me hagas esperar, dejame pasar",
	"¡Dale, tengo que entrar sí o sí!",
	"Revisá tranqui, está todo impecable.",
	"¡Mirá que no soy nuevo acá, eh!",
	"Soy cliente habitual, ¡dejame pasar!",
	"Che, no des más vueltas, ¿paso?",
	"¡Me tienen que ver adentro, es urgente!",
	"¿Ya revisaste? ¡Está todo bien!",
	"¡No me hagas esperar más, por favor!"
]

# --- SCREEN ASSETS ---
var win_screen = preload("res://images/win_screen.jpg")
var loose_screen = preload("res://images/LooseImage.jpg")

# --- TYPING SETTINGS ---
var typing_speed = 0.05

# --- CHARACTER SELECTION ---
var selected_index = -1
var selected_person
var correct_characters
var incorrect_characters

# --- UI STATE TRACKERS ---
var rules_visible = false
var result_screen_shown = false

# --- TIMING SETTINGS ---
var check_interval = 0.1
var time_since_last_check = 0.0

# --- GAMEPLAY MECHANICS ---
var energy = 100
var PERMITED_STRIKES = 2
var correct_character_needed = 8
var strikes = 0
var heart_sprites = []

# --- PLAYER ACTION TRACKERS ---
var is_holding = false
var progress = 0.0
var progress_time = 1.4

# --- TIMER SETTINGS ---
var start_time = 60
var end_time = 180
var current_time = start_time
var yellow_alarm_already_activated = false
var red_alarm_already_activated = false

# --- LEVEL SETTINGS ---
var current_level = 1
var max_level_reached_count = 3

# --- TUTORIAL SETTINGS ---
var tutorial_images = []
var current_tutorial_index = 0

func _ready():
	tutorial_images = [
		preload("res://images/tutorial/tutorial1.png"),
		preload("res://images/tutorial/tutorial2.png"),
		preload("res://images/tutorial/tutorial3.png"),
		preload("res://images/tutorial/tutorial4.png"),
		preload("res://images/tutorial/tutorial5.png"),
		preload("res://images/tutorial/tutorial6.png"),
		preload("res://images/tutorial/tutorial7.png"),
		preload("res://images/tutorial/tutorial8.png"),
		preload("res://images/tutorial/tutorial9.png"),
	]
	
	phone.texture = phone_display_level_1
	current_date.text = "04-10-2024"
	
	correct_characters = 0
	incorrect_characters = []
	correct_character_label.text = str(correct_characters) + " / " + str(correct_character_needed)
	
	heart_sprites = [heart3, heart2, heart1]
	for heart in heart_sprites:
		heart.texture = full_heart_icon
		
	apply_rules()
	accept_button.disabled = true
	reject_button.disabled = true
	
# --- CORE GAME LOOP AND TIMING FUNCTIONS ---
func _process(delta):
	if not countdown_timer.is_stopped() and not result_screen_shown:
		change_remaining_seconds(delta * 1.2)
	
func _on_countdown_timer_timeout():
	if current_time >= end_time:
		countdown_timer.stop()
		end_level()

func set_text_from_seconds(seconds):
	var minutes = int(seconds) / 60
	var remaining_seconds = int(seconds) % 60
	countdown_label.text = "%02d:%02d" % [minutes, remaining_seconds]

func change_remaining_seconds(delta):
	current_time += delta
	current_time = clamp(current_time, 0, end_time)
	set_text_from_seconds(current_time)
	
func add_seconds(seconds):
	change_remaining_seconds(seconds)

func subtract_seconds(seconds):
	change_remaining_seconds(-seconds)
	
# --- CHARACTER SELECTION AND DISPLAY FUNCTIONS ---
func new_selected_person():
	selected_index += 1
	if current_level == 1:
		return persons_first_level[selected_index]
	elif current_level == 2:
		return persons_second_level[selected_index]
	elif current_level == 3:
		return persons_third_level[selected_index]
	
func next_person():
	if current_level == 3 and not ticket_logo.visible:
		ticket_logo.visible = true
	selected_person = new_selected_person()
	character_animation_player.play("character_appear")	
	character_sprite.position = Vector2(-500, 0)	
	character_sprite.texture = selected_person["image"]
	
func display_person_dni(dni):
	if dni:
		name_label.text = dni["name"]
		born_date_label.text = dni["born_date"]
		due_date_label.text = dni["due_date"]
		portrait_sprite.texture = dni["document_photo"]
		portrait_sprite.visible = true
	else:
		clear_display()

func clear_display():
	name_label.text = ""
	born_date_label.text = ""
	due_date_label.text = ""
	portrait_sprite.visible = false
	
# --- BUTTON HANDLERS AND DIALOGUE FUNCTIONS ---
func _on_accept_button_pressed():
	hide_dialogue()
	handle_accept_reject(selected_person["problem"], true)

func _on_reject_button_pressed():
	hide_dialogue()
	handle_accept_reject(selected_person["problem"], false)
		
func handle_accept_reject(problem, wasAccepted):
	var correct_choice = false
	accept_button.disabled = true
	reject_button.disabled = true
	if selected_person["problem"] == "no_dni":
		random_credential_animation_player.play("random_credential_disappear")
	else:
		dni_animation_player.play("dni_disappear")
		if current_level != 1 and selected_person["problem"] != "no_ticket":
			ticket_animation_player.play("ticket_disappear")
	
	if problem in ["due_date", "born_date", "wrong_portrait", "no_dni", "no_ticket", "no_ticket_logo"]:
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
	
func hide_dialogue():
	player_dialogue_label.visible = false
	
# --- GAMEPLAY AND SCORING LOGIC ---
func handle_strikes():
	if strikes < PERMITED_STRIKES:
		rules_label_animation_player.play("twinkleHeart" + str(heart_sprites.size() - strikes))
		heart_sprites[strikes].texture = empty_heart_icon
		strikes += 1
	else:
		heart_sprites[strikes].texture = empty_heart_icon
		end_level()
		
func handle_incorrect_choice_notification(problem):
	var message = ""
	match problem:
		"due_date":
			message = "DNI caducado"
		"born_date":
			message = "No era mayor de edad"
		"wrong_portrait":
			message = "El retrato no era correcto"
		"no_dni":
			message = "Ni siquiera tenia DNI..."
		"no_ticket":
			message = "Faltaba el ticket de entrada"
		"no_ticket_logo":
			message = "El ticket no tenia el logo"
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
	correct_character_label.text = str(correct_characters) + " / " + str(correct_character_needed)
	if correct_characters >= correct_character_needed:
		end_level()
		
func end_level():
	accept_button.disabled = true
	reject_button.disabled = true
	if selected_person["problem"] == "no_dni":
		random_credential_animation_player.play("random_credential_disappear")
	else:
		dni_animation_player.play("dni_disappear")
		if current_level != 1:
			ticket_animation_player.play("ticket_disappear")
	fill_result_details()
	result_animation_player.play("show_results")
	countdown_timer.stop()
	result_screen_shown = true
	
# --- LEVEL AND GAME STATE ---
func next_level():
	accept_button.visible = true
	reject_button.visible = true
	countdown_timer.start()
	
	selected_index = -1
	correct_characters = 0
	incorrect_characters = []
	energy = 100
	strikes = 0
	progress = 0.0
	heart_sprites = [heart3, heart2, heart1]
	
	for heart in heart_sprites:
		heart.texture = full_heart_icon
	correct_character_label.text = str(correct_characters) + " / " + str(correct_character_needed)
	win_or_loose_label.text = ""
	wrong_choice_notification_label.text = ""
	
	accept_button.disabled = false
	reject_button.disabled = false
	result_screen_shown = false
	player_dialogue_label.text = ""		
	random_credential.visible = false
	random_credential_animation_player.stop()
	background_music.set_bus("Master")
	background_music.set_volume_db(0)
	next_person()
	
func fill_result_details():
	result_screen_shown = true
	accept_button.visible = false
	reject_button.visible = false
	countdown_timer.stop()
	current_time = start_time
	set_text_from_seconds(start_time)
	if strikes > PERMITED_STRIKES or correct_characters < correct_character_needed:
		win_or_loose_label.text = "PERDISTE"
		win_or_loose_label.modulate = Color(1, 0, 0)
		win_or_loose_screen.texture = loose_screen
		new_rule_notification.text = ""
		next_level_button_label.text = "Vamos de nuevo..."
	else:
		if current_level == 1:
			phone.texture = phone_display_level_2
		win_or_loose_screen.texture = win_screen
		win_or_loose_label.text = "GANASTE"
		win_or_loose_label.modulate = Color(0, 1, 0)
		next_level_button_label.text = "Siguiente dia..."
		new_rule_notification.text = "Nueva regla agregada al celular"
	total_characters_count.text = "Clientes totales: " + str(correct_characters + incorrect_characters.size())
	correct_characters_count.text = "Pasaron correctamente: " + str(correct_characters)
	incorrect_characters_count.text = "Errores: " + str(incorrect_characters.size())
		
func handle_new_level_settings():
	current_level += 1
	if current_level == 2:
		current_date.text = "05-10-2024"
		correct_character_needed = 7
		phone.texture = phone_display_level_2
	elif current_level == 3:
		ticket_logo.visible = true
		current_date.text = "06-10-2024"
		correct_character_needed = 8		
		
func display_end_screen():
	end_screen.visible = true
	
# --- RULE AND DIALOGUE FUNCTIONS ---
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
	
func show_dialogue():
	var randomIndex = randi() % dialogues.size()
	if randomIndex < dialogues.size():
		var dialogue = dialogues[randomIndex]
		_start_typing(dialogue)
		
func _start_typing(dialogue):
	var char_index = 0
	player_dialogue_label.text = ""		
	player_dialogue_label.visible = true
	while char_index < dialogue.length():
		player_dialogue_label.text += dialogue[char_index]
		char_index += 1
		await get_tree().create_timer(typing_speed).timeout
		
# --- UI AND ANIMATION EVENT HANDLERS ---
func _on_show_rules_button_pressed():
	if not rules_label_animation_player.is_playing():
		var animation = "rules_appear" if not rules_visible else "rules_disappear"
		rules_label_animation_player.play(animation)
		rules_visible = !rules_visible

func _on_animation_player_animation_finished(animation_name):
	if animation_name == "character_appear":
		character_animation_player.play("character_idle")
		wrong_choice_notification_label.text = "" 
	if animation_name == "character_enter" or animation_name == "character_no_enter":
		background_music.set_bus("New Bus")
		background_music.set_volume_db(0)
		next_person()
		
func _on_animation_player_animation_started(animation_name):
	if animation_name == "character_idle":
		show_dialogue()
		
		if current_level == 1:
			random_credential.scale = Vector2(0.2, 0.2)
			random_credential.texture = sube
		elif current_level == 2:
			random_credential.texture = ioma
		elif current_level == 3:
			random_credential.scale = Vector2(0.5, 0.5)
			random_credential.texture = pitusas
			
		if selected_person["problem"] == "no_dni":
			random_credential_animation_player.play("random_credential_appear")
		else:
			display_person_dni(selected_person["dni"])
			dni_animation_player.play("dni_appear")
			if current_level != 1 and selected_person["problem"] == "no_ticket_logo":
				ticket_logo.visible = false
				ticket_animation_player.play("ticket_appear")
			if current_level != 1 and selected_person["problem"] != "no_ticket" and not result_screen_shown:
				ticket_animation_player.play("ticket_appear")
		
func handle_character_enter_or_not_anim(wasAccepted):
	if wasAccepted:
		character_animation_player.play("character_enter")
		background_music.set_bus("Master")
		background_music.set_volume_db(background_music.get_volume_db() + 10)
	else:
		character_animation_player.play("character_no_enter")

func _on_dni_animation_player_animation_finished(animation_name):
	if animation_name == "dni_appear":
		accept_button.disabled = false
		reject_button.disabled = false
		
func _on_random_credential_animation_player_animation_finished(animation_name):
	if animation_name == "random_credential_appear":
		accept_button.disabled = false
		reject_button.disabled = false
		
func _on_result_animation_player_animation_finished(animation_name):
	if animation_name == "show_results":
		result_animation_player.play("show_labels")

func _on_accept_button_mouse_entered():
	accept_button.modulate = Color(1.0, 1.0, 1.0, 0.8)
	
func _on_accept_button_button_down():
	accept_button.icon = thumb_up_pressed
	accept_button.scale = Vector2(0.48, 0.5)
	
func _on_accept_button_button_up():
	accept_button.icon = thumb_up
	accept_button.scale = Vector2(0.5, 0.5)

func _on_accept_button_mouse_exited():
	accept_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func _on_accept_button_focus_entered():
	accept_button.texture = thumb_up_pressed
	
func _on_reject_button_button_down():
	reject_button.icon = thumb_down_pressed
	reject_button.scale = Vector2(0.48, 0.5)
	
func _on_reject_button_button_up():
	reject_button.icon = thumb_down
	reject_button.scale = Vector2(0.5, 0.5)

func _on_reject_button_mouse_entered():
	reject_button.modulate = Color(1.0, 1.0, 1.0, 0.8)

func _on_reject_button_mouse_exited():
	reject_button.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_next_level_button_pressed():
	result_animation_player.play("hide_results")
	if correct_characters >= correct_character_needed:
		handle_new_level_settings()
		
	if current_level > max_level_reached_count:
		display_end_screen()
	else:
		next_level()

func _on_play_pressed():
	menu_animation_player.play("slowly_stop_menu_music")
	cinematic_animation_player.play("slowly_start_cinematic_music")
	main_cinematic.visible = true
	main_cinematic.play()
	start_first_level_screen.visible = true
	menu.visible = false

func _on_main_cinematic_finished():
	start_first_level_button.visible = true
	first_rules_notification.visible = true
	cinematic_animation_player.play("slowly_stop_cinematic_music")
	main_cinematic.visible = false
	phone.visible = true

func start_first_level():
	background_music.play()
	next_person()
	set_text_from_seconds(current_time)
	countdown_timer.start()
	
func _input(event):
	if tutorial_panel.is_visible():
		if event is InputEventMouseButton and event.pressed:
			current_tutorial_index += 1
			if current_tutorial_index < tutorial_images.size():
				tutorial_display.texture = tutorial_images[current_tutorial_index]
			else:
				tutorial_panel.hide()
				tutorial_display.hide()
				
func _on_play_mouse_entered():
	play_button.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_play_mouse_exited():
	play_button.modulate = Color(1.0, 1.0, 1.0, 1)

func _on_how_to_play_mouse_entered():
	how_to_play_button.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_how_to_play_mouse_exited():
	how_to_play_button.modulate = Color(1.0, 1.0, 1.0, 1)

func _on_how_to_play_pressed():
	current_tutorial_index = 0
	tutorial_display.texture = tutorial_images[current_tutorial_index]
	tutorial_panel.show()
	tutorial_display.show()

func _on_play_first_level_button_pressed():
	first_level_animation_player.play("hide_start_level_screen")
	start_first_level()

func _on_play_first_level_button_mouse_entered():
	start_first_level_button.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_play_first_level_button_mouse_exited():
	start_first_level_button.modulate = Color(1.0, 1.0, 1.0, 1)

func _on_next_level_button_mouse_entered():
	next_level_button.modulate = Color(1.0, 1.0, 1.0, 0.5)

func _on_next_level_button_mouse_exited():
	next_level_button.modulate = Color(1.0, 1.0, 1.0, 1)
