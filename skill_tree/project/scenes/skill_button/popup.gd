extends Control

func _ready():
	var stats = get_parent().stats
	$Name.text = stats.name
	$Description.text = "\n"+stats.description
