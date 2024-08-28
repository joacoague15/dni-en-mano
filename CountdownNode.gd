extends Node

@onready var countdown_label = $CountdownLabel
@onready var countdown_timer = $CountdownTimer

var countdown_time = 3

func _ready():
	countdown_timer.wait_time = 1.0
	countdown_timer.one_shot = false
	countdown_timer.start()
	update_countdown_label()
	
	countdown_timer.timeout.connect(_on_CountdownTimer_timeout)

func _on_CountdownTimer_timeout():
	countdown_time -= 1
	update_countdown_label()
	
	if countdown_time <= 0:
		countdown_timer.stop()
		countdown_time = 0
		on_countdown_finished()

func update_countdown_label():
	countdown_label.text = str(countdown_time)

func on_countdown_finished():
	print("Countdown finished!")
