extends Node

@onready var player_dialogue_label = $PlayerDialogueLabel
@onready var character_dialogue_label = $CharacterDialogueLabel
@onready var dni_animation_player = get_node("../DNIInformation/DNIAnimationPlayer")

var dialogues = [
	{"character": "Player", "text": "DNI en mano", "time": 1.4},
	{"character": "Character", "text": "Aca esta", "time": 1},
]

var index = 0

func show_dialogue():
	if index < dialogues.size():
		var dialogue = dialogues[index]
		if index == 0:
			await get_tree().create_timer(0.8).timeout
		
		if dialogue["character"] == "Player":
			player_dialogue_label.text = dialogue["text"]
			player_dialogue_label.visible = true
		else:
			character_dialogue_label.text = dialogue["text"]
			character_dialogue_label.visible = true
		
		await get_tree().create_timer(dialogue["time"]).timeout
		index += 1
		show_dialogue()
	else:
		await get_tree().create_timer(0.5).timeout		
		hide_dialogues()
		index = 0

func hide_dialogues():
	player_dialogue_label.visible = false
	character_dialogue_label.visible = false
