extends Node

@onready var countdown_label = $CountdownLabel
@onready var countdown_label_animator = $CountdownAnimationPlayer
@onready var countdown_timer = $CountdownTimer
@onready var result_animation_player = get_node("../ResultScreen/ResultAnimationPlayer")

var start_time = 60
var end_time = 180
var current_time = start_time
var yellow_alarm_already_activated = false
var red_alarm_already_activated = false
var result_screen_shown = false

func _ready():
	set_text_from_seconds(current_time)
	countdown_timer.start()

func _process(delta):
	if countdown_timer.is_stopped() and not result_screen_shown:
		result_animation_player.play("show_results")
		result_screen_shown = true
	change_remaining_seconds(delta * 7)

func _on_countdown_timer_timeout():
	if current_time >= end_time:
		countdown_timer.stop()
	else:
		if current_time >= 120 and not yellow_alarm_already_activated:
			countdown_label_animator.play("yellow_alarm")
			yellow_alarm_already_activated = true
		if current_time >= 150 and not red_alarm_already_activated:
			countdown_label_animator.play("red_alarm")
			red_alarm_already_activated = true

func set_text_from_seconds(seconds):
	var minutes = int(seconds) / 60
	var remaining_seconds = int(seconds) % 60
	countdown_label.text = "%02d:%02d" % [minutes, remaining_seconds]

func change_remaining_seconds(delta):
	current_time += delta
	current_time = clamp(current_time, 0, end_time)  # Clamp between 0 and end_time
	set_text_from_seconds(current_time)

func add_seconds(seconds):
	change_remaining_seconds(seconds)

func subtract_seconds(seconds):
	change_remaining_seconds(-seconds)
