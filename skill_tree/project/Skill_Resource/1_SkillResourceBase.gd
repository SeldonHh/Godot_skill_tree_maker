extends Resource

class_name SkillResource

@export_category("identification")
@export var name : String = 'UNDEFINED SKILL'
@export var texture : Texture2D = preload("res://project/icon.svg")
@export var description : String = "UNDEFINED DESCRIPTION"

@export_category("skill_parameters")
@export var max_level : int = 1
@export var level : int = 0
@export var base_upgrade : bool = false
@export var cost : int

@export_category('requirements')
@export var skill_required : SkillResource
@export var skill_level_required : int = 1
