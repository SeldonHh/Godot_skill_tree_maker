extends Node

var skill_point = 0

func get_runtime_children(parent: Node):
	var runtime_children = []
	for child in parent.get_children():
		if child.owner == parent.get_owner():
			runtime_children.append([child])
	return runtime_children
