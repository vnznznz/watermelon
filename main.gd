extends Node2D

@export var fruits:Array[PackedScene]

var next_fruit_level = 0
var next_fruit:Fruit = null

# Called when the node enters the scene tree for the first time.
func _ready():
	next_fruit = add_fruit(next_fruit_level, get_global_mouse_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):		
	if Input.is_action_just_pressed("click"):
		next_fruit.process_mode = Node.PROCESS_MODE_INHERIT
		next_fruit_level = randi() % 4
		next_fruit = add_fruit(next_fruit_level, get_global_mouse_position())
		
	if next_fruit:
		next_fruit.global_position.y = 100
		next_fruit.global_position.x = get_global_mouse_position().x
		

func add_fruit(level:int, position:Vector2):
	var fresh_fruit:Fruit = fruits[level].instantiate()
	fresh_fruit.global_position = position
	fresh_fruit.on_collide_same_fruit.connect(on_collide_same_fruit)
	fresh_fruit.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(fresh_fruit)
	return fresh_fruit


func on_collide_same_fruit(fruit_a:Fruit, fruit_b:Fruit):	
	if fruit_a.fruit_level == len(fruits) - 1:
		return
	
	var new_fruit:Fruit = null
	if fruit_a.global_position.y > fruit_b.global_position.y:
		new_fruit = add_fruit(fruit_a.fruit_level + 1, fruit_a.global_position)
	else:
		new_fruit = add_fruit(fruit_a.fruit_level + 1, fruit_b.global_position)
	
	fruit_a.queue_free()
	fruit_b.queue_free()
	
	
	new_fruit.process_mode = Node.PROCESS_MODE_ALWAYS
	new_fruit.apply_central_impulse(Vector2.UP * 200)
	
		


