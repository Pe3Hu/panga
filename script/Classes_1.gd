extends Node


#Камень stein
class Stein:
	var num = {}
	var vec = {}
	var dict = {}
	var flag = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		vec.grid = input_.grid
		num.parity = int(vec.grid.y)%2
		dict.neighbor = {}
		obj.berggipfel = input_.berggipfel
		flag.on_screen = false
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.stein.instantiate()
		scene.myself.set_parent(self)
		obj.berggipfel.scene.myself.get_node("Stein").add_child(scene.myself)


#Скала felsen
class Felsen:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		arr.index = input_.indexs
		obj.berggipfel = input_.berggipfel
		#init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.felsen.instantiate()
		scene.myself.set_parent(self)
