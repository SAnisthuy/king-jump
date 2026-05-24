extends Node2D
@onready var answer_1: Button = $CanvasLayer/GridContainer/Answer1
@onready var answer_2: Button = $CanvasLayer/GridContainer/Answer2
@onready var answer_3: Button = $CanvasLayer/GridContainer/Answer3
@onready var answer_4: Button = $CanvasLayer/GridContainer/Answer4
@onready var question: Label = $CanvasLayer/Question

var opened = true
var closed = false
var correct = null

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	initialize()
 
func close():
	get_tree().paused = false
	queue_free()	

func initialize():
	var answers = [answer_1, answer_2, answer_3, answer_4]
	var QandA = Questions.get_question()
	question.text = str(QandA["question"])
	for i in range(4):
		answers[i].text = str(QandA["answers"][i])
	correct = int(QandA["correct"]) + 1
	
func check_answer(choice: int):
	if correct == choice:
		Questions.correct = true
	else:
		Questions.correct = false
		GameManager.player_health -= 20

	close()

func _on_answer_1_pressed() -> void:
	check_answer(1)


func _on_answer_2_pressed() -> void:
	check_answer(2)
	
func _on_answer_3_pressed() -> void:
	check_answer(3)

func _on_answer_4_pressed() -> void:
	check_answer(4)
