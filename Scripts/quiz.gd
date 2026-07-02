extends Node2D
@onready var answer_1: Button = $CanvasLayer/TextureRect/VBoxContainer/Answer1
@onready var answer_2: Button = $CanvasLayer/TextureRect/VBoxContainer/Answer2
@onready var answer_3: Button = $CanvasLayer/TextureRect/VBoxContainer/Answer3
@onready var answer_4: Button = $CanvasLayer/TextureRect/VBoxContainer/Answer4

@onready var question: Label = $CanvasLayer/TextureRect/CenterContainer/Question

@onready var collection_sfx: AudioStreamPlayer = $collectionSFX
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var damage_sfx: AudioStreamPlayer = $damageSFX
@onready var timer: Timer = $Timer

var opened = true
var closed = false

var correct = null

var closing = false
var player_correct = null



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	initialize()
 
func close():
	if closing:
		return
	closing = true
	audio_stream_player.stop()
	if player_correct:
		collection_sfx.play()
		GameManager.healing = true
		await collection_sfx.finished
	else:
		damage_sfx.play()
		await damage_sfx.finished
	timer.start()
	await timer.timeout
	get_tree().paused = false
	queue_free()	

func initialize():
	var answers = [answer_1, answer_2, answer_3, answer_4]
	var QandA = shuffle_question(Questions.get_question())
	question.text = str(QandA["question"])
	for i in range(4):
		answers[i].text = str(QandA["answers"][i])
	correct = int(QandA["correct"]) + 1
	
func check_answer(choice: int):
	var answers = [answer_1, answer_2, answer_3, answer_4]
	if Collectables.coins > 0:
		Collectables.coins -= 1
	if correct == choice:
		player_correct = true
	else:
		player_correct = false
		GameManager.player_health -= 20
		
	for i in range(len(answers)):
		if i == correct - 1:
			answers[i].modulate = Color(0.0, 0.965, 0.151, 1.0)
		else:
			answers[i].modulate = Color(1.0, 0.0, 0.004, 1.0)		
	
	close()

func shuffle_question(q):
	var pairs = []

	for i in range(q["answers"].size()):
		pairs.append({
			"text": q["answers"][i],
			"is_correct": i == q["correct"]
		})

	pairs.shuffle()

	var new_answers = []
	var new_correct = 0

	for i in range(pairs.size()):
		new_answers.append(pairs[i]["text"])
		if pairs[i]["is_correct"]:
			new_correct = i

	return {
		"question": q["question"],
		"answers": new_answers,
		"correct": new_correct
	}

func _on_answer_1_pressed() -> void:
	check_answer(1)

func _on_answer_2_pressed() -> void:
	check_answer(2)
	
func _on_answer_3_pressed() -> void:
	check_answer(3)

func _on_answer_4_pressed() -> void:
	check_answer(4)
