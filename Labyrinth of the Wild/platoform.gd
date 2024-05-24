extends StaticBody2D

@export var direction = 1
@export var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position.x += direction * speed * delta
	$Sprite2D.position.x += direction * speed * delta
	$CollisionShape2D.position.x += direction * speed * delta
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	direction = -direction
