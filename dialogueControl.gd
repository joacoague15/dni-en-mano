extends Node

@onready var player_dialogue_label = $CharacterDialogueLabel

var dialogues = [
	"Buenas"
]

var index = 0
var typing_speed = 0.05

func show_dialogue():
	if index < dialogues.size():
		var dialogue = dialogues[0]
		_start_typing(dialogue)
		
func _start_typing(dialogue):
	var char_index = 0
	while char_index < dialogue.length():
		player_dialogue_label.text += dialogue[char_index]
		char_index += 1
		await get_tree().create_timer(typing_speed).timeout
		
func hide_dialogue():
	player_dialogue_label.text = ""	
