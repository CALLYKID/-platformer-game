extends Node2D
@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

var level: int = 1
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func _setup_level() -> void:
	
	#connect flag
	
	var exit = $LevelRoot.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)

	#connect apples
	
	var apples = $LevelRoot.get_node_or_null("Apples")
	if apples:
		for Apples in apples.get_children():
			Apples.collected.connect(increase_score)

#connect enemies

	var enemies = $LevelRoot.get_node_or_null("enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)



#------------------
# SIGNAL HANDLERS
#--------------------

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		level+= 1
		print(level)
		body.can_move = false
		
func _on_player_died(body):
	body.die()
	print("Player Killed")


#----------------
# SCORE
#-----------------

func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
	
