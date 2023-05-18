extends Node


#Горный пик berggipfel
class Berggipfel:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		obj.felssturz = input_.felssturz
		init_scene()
		init_steins()


	func init_scene() -> void:
		scene.myself = Global.scene.berggipfel.instantiate()
		scene.myself.set_parent(self)
		obj.felssturz.scene.myself.get_node("Berggipfel").add_child(scene.myself)
		

	func init_steins() -> void:
		arr.stein = []
		
		for _i in Global.num.size.berggipfel.rows:
			arr.stein.append([])
			
			for _j in Global.num.size.berggipfel.cols:
				var input = {}
				input.grid = Vector2(_j,_i)
				input.berggipfel = self
				var stein = Classes_1.Stein.new(input)
				arr.stein[_i].append(stein)
		
		init_stein_neighbors()


	func init_stein_neighbors() -> void:
		for steins in arr.stein:
			for stein in steins:
				for direction in Global.arr.neighbor[stein.num.parity]:
					var grid = stein.vec.grid + direction
					
					if check_grid_on_berggipfel(grid):
						var neighbor = arr.stein[grid.y][grid.x]
						stein.dict.neighbor[neighbor] = direction


	func get_steins_around_stein(stein_, rings_) -> Array:
		var arounds = [[stein_]]
		var totals = [stein_]
		
		for _i in rings_:
			var next_ring = []
			
			for _j in range(arounds[_i].size()-1,-1,-1):
				for neighbor in arounds[_i][_j].dict.neighbor.keys():
					if !totals.has(neighbor):
						next_ring.append(neighbor)
						totals.append(neighbor)
			
			arounds.append(next_ring)
		
		return arounds


	func check_grid_on_berggipfel(grid_) -> bool:
		return grid_.y >= 0 and grid_.x >= 0 and grid_.y < arr.stein.size() and grid_.x < arr.stein[0].size()


#Камнепад felssturz
class Felssturz:
	var obj = {}
	var scene = {}


	func _init():
		init_scene()
		init_berggipfel()


	func init_scene() -> void:
		scene.myself = Global.scene.felssturz.instantiate()
		#scene.myself.set_parent(self)
		Global.node.game.get_node("Layer0").add_child(scene.myself)


	func init_berggipfel() -> void:
		var input = {}
		input.felssturz = self
		obj.berggipfel = Classes_0.Berggipfel.new(input)
