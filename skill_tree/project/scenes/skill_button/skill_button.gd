extends TextureButton
class_name SkillNode

@onready var popup = $Popup
@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@export var stats : SkillResource
#Returns an Array of Arrays that consist all of 1 element , one of our child (Node)
@onready var children : Array = GameManager.get_runtime_children(self)
var can_buy : bool = false

func _process(_delta):
	#Set the right level text
	label.text = str(stats.level) + "/"+str(stats.max_level)
	#Make the popup a bit offset to our mouse 
	popup.global_position = get_global_mouse_position() + Vector2(100,0)
	#if our child are max_level, set our line to them to green (probably very unoptimized)
	for child in children:
			if child[0].stats.level == child[0].stats.max_level:
				color_line(child[1],Color(0,1,0))


func _ready():
	#Set the sprite of the skill
	texture_normal = stats.texture
	popup.hide()
	#Hide the level label if there's only one label (for swag)
	if stats.max_level == 1:
		label.hide()
		
	#Make the skill buyable if it's a base upgrade duh
	if stats.base_upgrade:
		can_buy = true
	
	#Add a line to all of our child
	for child in children:
		var newline = Line2D.new()
		#Make it so that each "child" array are attributed a line to them
		child.append(newline)
		#Make the line kinda gray
		color_line(newline,Color(0.3,0.3,0.3))
		newline.width = 3
		newline.show_behind_parent = true
		add_child(newline)
		#since line2d are in local pos we need to use to_local | child[0] is one of our child_node
		newline.add_point(newline.to_local(global_position + size /2 ))
		newline.add_point(newline.to_local(child[0].global_position + child[0].size / 2))

func _on_pressed():
	#Check if we have enough skill points and if the skill is buyable
	if can_buy and GameManager.skill_point >= stats.cost:
		#Deduct the skill cost to our skill points
		GameManager.skill_point -= stats.cost 
		#Ensure it cannot go above the max_level
		stats.level = min(stats.level+1,stats.max_level)
		#Hide the shadow to signify the skill is bought
		panel.show_behind_parent = true
		for child in children:
			#Do stuff to our child if we are the level he requires
			if child[0].stats.skill_level_required <= stats.level:
				#Make our children buyable
				child[0].can_buy = true
				#Make the line to our children yellow to signify we can buy them
				color_line(child[1],Color(1,1,0))

func color_line(line,color):
	#We just color a line
	line.default_color = color

func _on_mouse_entered():
	#Show the description and name
	popup.show()


func _on_mouse_exited():
	#Hide the description and name
	popup.hide()
