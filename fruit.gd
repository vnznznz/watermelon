class_name Fruit
extends RigidBody2D


@export var fruit_level :int = 0
var default_font:Font

signal on_collide_same_fruit(fruit_a, fruit_b)

# Called when the node enters the scene tree for the first time.
func _ready():
	default_font = Control.new().get_theme_default_font()
	3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func level_up():
	pass

func _physics_process(delta):				
	for body in get_colliding_bodies():
		if is_instance_of(body, Fruit):
			handle_fruit_collision(body)

func handle_fruit_collision(other_fruit:Fruit):	
	if self.is_queued_for_deletion() or other_fruit.is_queued_for_deletion():
		return
	if other_fruit.fruit_level == fruit_level:
		on_collide_same_fruit.emit(self, other_fruit)
		


func _on_body_entered(other_body):
	if is_instance_of(other_body, Fruit):
		handle_fruit_collision(other_body)
	
	
