extends CanvasLayer

var score: int = 0
var health : int = 5

func add_score(num: int):
	score += num
	$Label.text = "Score: " + str(score)

func take_damage(num: int):
	health -= num
	$Label2.text = "Life: " + str(health)
