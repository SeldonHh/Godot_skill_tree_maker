extends Camera2D


func _process(delta):
	var direction = Input.get_vector("left","right","up","down")
	var velocity : Vector2
	
	if direction :
		velocity = direction * delta * 300
	else:
		velocity = lerp(velocity,Vector2(0,0),delta*16)

	position += velocity
