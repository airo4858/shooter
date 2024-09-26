extends CanvasLayer

var score: int = 0

func add_score(num: int):
	score += num
	$Label.text = "Score: " + str(score)
