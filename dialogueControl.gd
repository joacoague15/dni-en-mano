extends Node

@onready var player_dialogue_label = $PlayerDialogueLabel
@onready var character_dialogue_label = $CharacterDialogueLabel

var dialogues = [
	{"character": "Player", "text": "DNI en mano", "time": 2.0},
	{"character": "Character", "text": "Aca esta", "time": 2.0},
]

func show_dialogue(index):
	if index < dialogues.size():
		var dialogue = dialogues[index]
		if dialogue["character"] == "Player":
			player_dialogue_label.text = dialogue["text"]
		else:
			character_dialogue_label.text = dialogue["text"]
		
		await get_tree().create_timer(dialogue["time"]).timeout
		index += 1
		show_dialogue(index)
