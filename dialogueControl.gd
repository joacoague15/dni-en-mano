extends Node

@onready var player_dialogue_label = $CharacterDialogueLabel

var dialogues = [
	"Buenas",
	"¿Todo bien?",
	"Buenas, ¿cómo va?",
	"Está todo en regla. ¿Me dejás pasar?",
	"¿Todo bien por acá? ¿puedo entrar?",
	"Está todo bien, ¿me das el OK?",
	"Dale, ya me conocen acá ¿Me dejás?",
	"¡Sería un crimen no dejarme entrar!",
	"¡La pista me necesita!"
]

var typing_speed = 0.05

func show_dialogue():
	var randomIndex = randi() % dialogues.size()
	if randomIndex < dialogues.size():
		var dialogue = dialogues[randomIndex]
		_start_typing(dialogue)
		
func _start_typing(dialogue):
	var char_index = 0
	while char_index < dialogue.length():
		player_dialogue_label.text += dialogue[char_index]
		char_index += 1
		await get_tree().create_timer(typing_speed).timeout
		
func hide_dialogue():
	player_dialogue_label.text = ""	
