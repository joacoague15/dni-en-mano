extends Node

@onready var player_label = $PlayerDialogueLabel
@onready var character_label = $CharacterDialogueLabel

var dialogues = [
	{"character": "PLayer", "text": "Papers, please.", "time": 2.0},
	{"character": "Character", "text": "Here you go.", "time": 2.0},
]

var current_index = 0

func _ready():
	player_label.position = Vector2(40, 70)  # Set the x and y position for the player label
	character_label.position = Vector2(100, 100)  # Set the x and y position for the character label
	show_next_dialogue()

func show_next_dialogue():
	if current_index < dialogues.size():
		var dialogue = dialogues[current_index]

		player_label.text = ""
		character_label.text = ""

		if dialogue["character"] == "Player":
			player_label.text = dialogue["text"]
		else:
			character_label.text = dialogue["text"]

		var duration = dialogue["time"]
		current_index += 1
		await get_tree().create_timer(duration).timeout
		show_next_dialogue()
