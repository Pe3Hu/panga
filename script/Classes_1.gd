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
		num.index = Global.num.index.stein
		Global.num.index.stein += 1
		dict.neighbor = {}
		dict.rotate = {}
		obj.berggipfel = input_.berggipfel
		flag.felsen = false
		flag.on_screen = false
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.stein.instantiate()
		scene.myself.set_parent(self)
		obj.berggipfel.scene.myself.get_node("Stein").add_child(scene.myself)


#Скала felsen
class Felsen:
	var num = {}
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		num.index = Global.num.index.felsen
		Global.num.index.felsen += 1
		arr.index = input_.indexs
		obj.berggipfel = input_.berggipfel
		set_stein()
		#init_scene()


	func set_stein() -> void:
		arr.stein = []
		
		for index in arr.index:
			var stein = obj.berggipfel.get_stein_by_index(index)
			arr.stein.append(stein)


	func init_scene() -> void:
		scene.myself = Global.scene.felsen.instantiate()
		scene.myself.set_parent(self)
