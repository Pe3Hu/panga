extends Node


#Горный пик berggipfel
class Berggipfel:
	var num = {}
	var arr = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		obj.felssturz = input_.felssturz
		num.felsen = 0
		init_scene()
		init_steins()
		#init_felsen()
		#draw_felsen()


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


	func init_felsen() -> void:
		arr.felsen = []
		var hexagexs = []
		var hexagex = [0,1,2,3,4,5]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,4,10]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,4,9]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,4,8]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,9,10]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,9,16]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,9,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,8,9]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,8,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,8,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,7,8]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,7,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,7,9]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,6,9]
		hexagexs.append(hexagex)
		hexagex = [1,2,3,4,6,10]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,3,6,8]
		hexagexs.append(hexagex)
		hexagex = [4,6,7,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [0,6,7,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,9,15]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,8,9,15]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,9,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,15,16]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,9,10]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,15,20]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,14,19]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,9,4]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,9,16]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,14,20]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,8,14,13]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,9,14,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,14,15,21]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,14,19,26]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,14,18,19]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,8,15,16]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,8,15,20]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,9,14,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,3,4,7,8]
		hexagexs.append(hexagex)
		hexagex = [1,2,6,8,13,14]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,8,9,14]
		hexagexs.append(hexagex)
		hexagex = [0,2,6,7,12,14]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,14,20,21]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,9,14,15]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,14,15,16]
		hexagexs.append(hexagex)
		hexagex = [2,6,7,14,15,21]
		hexagexs.append(hexagex)
		hexagex = [2,7,12,13,19,26]
		hexagexs.append(hexagex)
		hexagex = [2,3,6,7,14,20]
		hexagexs.append(hexagex)
		hexagex = [2,3,6,7,14,15]
		hexagexs.append(hexagex)
		hexagex = [2,3,6,7,14,19]
		hexagexs.append(hexagex)
		hexagex = [1,7,12,13,19,25]
		hexagexs.append(hexagex)
		hexagex = [2,7,12,13,19,25]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,14,19]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,13,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,7,13]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,7,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,8,13]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,8,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,7,8,9]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,7,8]
		hexagexs.append(hexagex)
		hexagex = [1,2,3,6,8,9]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,7,8,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,7,8,14]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,7,8,13]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,14,15]
		hexagexs.append(hexagex)
		hexagex = [0,2,3,6,7,9]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,14,15]
		hexagexs.append(hexagex)
		hexagex = [0,6,7,8,14,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,8,9]
		hexagexs.append(hexagex)
		hexagex = [3,4,6,7,8,13]
		hexagexs.append(hexagex)
		hexagex = [2,8,12,13,14,18]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,13,15]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,8,15]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,15,21]
		hexagexs.append(hexagex)
		hexagex = [0,1,2,6,8,12]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,13,18]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,13,19]
		hexagexs.append(hexagex)
		hexagex = [3,6,7,8,14,20]
		hexagexs.append(hexagex)
		hexagex = [0,1,7,8,14,19]
		hexagexs.append(hexagex)
		hexagex = [1,6,7,8,13,15]
		hexagexs.append(hexagex)
		hexagex = [1,6,13,14,19,25]
		hexagexs.append(hexagex)
		
		for hexagex_ in hexagexs:
			var input = {}
			input.indexs = hexagex_
			input.berggipfel = self
			var felsen = Classes_1.Felsen.new(input)
			arr.felsen.append(felsen)
		
		var path = "res://asset/json/hexagex_data"
		var str_ = ""
		var datas = {}
		
		for _j in hexagexs.size():
			var hexagex_ = hexagexs[_j]
			var data = {}
			
			for _i in hexagex_.size():
				var index = hexagex_[_i]
				data[_i] = index
			
			datas[_j] = hexagex_
		
		print(datas)
		
		var jstr = JSON.stringify(datas)
		print(jstr)
		Global.save(path, jstr)


	func draw_felsen() -> void:
		num.felsen = (num.felsen+1+arr.felsen.size())%arr.felsen.size()
		var felsen = arr.felsen[num.felsen]
		
		for steins in arr.stein:
			for stein in steins:
				stein.flag.on_screen = false
				stein.scene.myself.update_color()
		
		for index in felsen.arr.index:
			var stein = get_stein_by_index(index)
			stein.flag.on_screen = true
			stein.scene.myself.update_color()


	func get_stein_by_index(index_: int) -> Classes_1.Stein:
		var x = index_%Global.num.size.berggipfel.cols 
		var y = index_/Global.num.size.berggipfel.cols 
		var stein = arr.stein[y][x]
		
		return stein


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
