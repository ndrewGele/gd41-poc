class_name StageCamera

extends Camera3D

@export var y_offset: float = 25.0
var camera_targets: Array[Node] = []
var target_position: Vector3 = Vector3.ZERO

func follow_targets(targets: Array[Node] = self.camera_targets):
	var all_x: Array[float] = []
	var all_y: Array[float] = []
	for target in targets:
		all_x.append(target.position.x)
		all_y.append(target.position.y)
	
	var sum_x: float = 0.0
	for x in all_x:
		sum_x += x
	
	var sum_y: float = 0.0
	for y in all_y:
		sum_y += y
	
	var mean_x: float = sum_x / float(targets.size())
	var mean_y: float = sum_y / float(targets.size())
	
	target_position = Vector3(mean_x, mean_y, 15.0)
	

func _ready():
	self.position = Vector3(0.0,0.0,15.0)
	

func _physics_process(delta):
	if camera_targets.size() > 0:
		follow_targets()
	
	self.position = self.position.lerp(target_position, delta * 1)
