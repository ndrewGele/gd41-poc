extends Node3D

func _load_stage(stage):
	var loaded_stage = load(stage)
	var inst_stage = loaded_stage.instantiate()
	return(inst_stage)
	
func _load_character(character, _player):
	var loaded_character = load(character)
	var inst_character = loaded_character.instantiate()
	return(inst_character)

func _ready():
	var stage = _load_stage('./stages/test_stage.tscn')
	self.add_child(stage)
	var character1 = _load_character('./characters/test_char.tscn', true)
	$Characters.add_child(character1)
	
	var stage_camera = StageCamera.new()
	stage_camera.camera_targets = $Characters.get_children()
	add_child(stage_camera)

