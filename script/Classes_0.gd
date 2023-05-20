extends Node


#Горный пик berggipfel
class Berggipfel:
	var num = {}
	var arr = {}
	var dict = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		obj.felssturz = input_.felssturz
		num.felsen = 0
		init_scene()
		init_steins()
		init_felsen()
		draw_felsen()


	func init_scene() -> void:
		scene.myself = Global.scene.berggipfel.instantiate()
		scene.myself.set_parent(self)
		obj.felssturz.scene.myself.get_node("Berggipfel").add_child(scene.myself)


	func init_steins() -> void:
		arr.stein = []
		
		for _i in Global.num.size.berggipfel.row:
			arr.stein.append([])
			
			for _j in Global.num.size.berggipfel.col:
				var input = {}
				input.grid = Vector2(_j,_i)
				input.berggipfel = self
				var stein = Classes_1.Stein.new(input)
				arr.stein[_i].append(stein)
		
		init_stein_neighbors()
		init_around_center()
		init_stein_rotates()


	func init_around_center() -> void:
		var center_grid = Vector2(Global.num.size.berggipfel.col/2,Global.num.size.berggipfel.row/2)
		var center_stein = arr.stein[center_grid.y][center_grid.x]
		var ring = Global.num.size.berggipfel.col/2
		var arounds = get_steins_around_stein(center_stein, ring)
		
		for arounds_ in arounds:
			for stein_ in arounds_:
				stein_.flag.on_screen = true
				stein_.scene.myself.visible = true


	func init_stein_neighbors() -> void:
		for steins in arr.stein:
			for stein in steins:
				for direction in Global.dict.neighbor.hex[stein.num.parity]:
					var grid = stein.vec.grid + direction
					
					if check_grid_on_berggipfel(grid):
						var neighbor = arr.stein[grid.y][grid.x]
						stein.dict.neighbor[neighbor] = direction


	func init_stein_rotates() -> void:
		var n = Global.num.size.berggipfel.n
		var m = Global.num.size.berggipfel.n/2
		var rotates = ["clockwise","counterclockwise"]
		var center_grid = Vector2(Global.num.size.berggipfel.col/2,Global.num.size.berggipfel.row/2)
		var center_stein = arr.stein[center_grid.y][center_grid.x]
		
		
		for rotate in rotates:
			center_stein.dict.rotate[rotate] = center_stein
		
		for _i in range(1,m,1):
			var axises = []
			
			for _j in Global.dict.neighbor.hex[center_stein.num.parity].size():
				var axis_grid = center_grid+Vector2()
				
				for _l in _i:
					var axis_direction = Global.dict.neighbor.hex[int(axis_grid.y)%2][_j]
					axis_grid += axis_direction
				
				var axis_stein = arr.stein[axis_grid.y][axis_grid.x]
				var steins = [axis_stein]
				
				var shfit_grid = axis_grid+Vector2()
				var shift = (_j+2)%n
				
				for _l in _i-1:
					var shift_direction = Global.dict.neighbor.hex[int(shfit_grid.y)%2][shift]
					shfit_grid += shift_direction
					var shfit_stein = arr.stein[shfit_grid.y][shfit_grid.x]
					steins.append(shfit_stein)
				
				axises.append(steins)
			
			for _j in axises.size():
				for _l in axises[_j].size():
					var stein = axises[_j][_l]
					
					for rotate in rotates:
						var shift = 0
						
						match rotate:
							"clockwise":
								shift = 1
							"counterclockwise":
								shift = 5
					
						shift = (_j+shift)%n
						stein.dict.rotate[rotate] = axises[shift][_l]
		
		var grid = Vector2(1,0)
		var stein = arr.stein[grid.y][grid.x]


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
		var indexs = 22
		
		var pentahexs = []
		var pentahex = [1,6,12,17,23]
		pentahexs.append(pentahex)
		pentahex = [1,6,12,17,18]
		pentahexs.append(pentahex)
		pentahex = [1,6,12,13,17]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,12,17]
		pentahexs.append(pentahex)
		pentahex = [1,2,6,12,17]
		pentahexs.append(pentahex)
		pentahex = [1,6,12,13,14]
		pentahexs.append(pentahex)
		pentahex = [1,6,12,13,18]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,12,13]
		pentahexs.append(pentahex)
		pentahex = [1,2,7,13,17]
		pentahexs.append(pentahex)
		pentahex = [1,2,6,7,12]
		pentahexs.append(pentahex)
		pentahex = [1,6,12,13,16]
		pentahexs.append(pentahex)
		pentahex = [1,2,5,11,12]
		pentahexs.append(pentahex)
		pentahex = [1,3,6,7,12]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,8,12]
		pentahexs.append(pentahex)
		pentahex = [1,2,6,12,16]
		pentahexs.append(pentahex)
		pentahex = [1,5,11,16,21]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,11,12]
		pentahexs.append(pentahex)
		pentahex = [1,2,6,11,12]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,13,17]
		pentahexs.append(pentahex)
		pentahex = [1,6,7,11,16]
		pentahexs.append(pentahex)
		pentahex = [1,5,11,15,21]
		pentahexs.append(pentahex)
		
		for pentahex_ in pentahexs:
			var input = {}
			input.indexs = pentahex_#Global.dict.pentahex[str(indexs_)]
			input.berggipfel = self
			var felsen = Classes_1.Felsen.new(input)
			arr.felsen.append(felsen)
		
		rotate_felsens()


	func rotate_felsens() -> void:
		dict.pentahex = {}
		dict.pentahex.rotate = {}
		dict.pentahex.index = []
		
		for felsen in arr.felsen:
			var indexs = felsen.arr.index
			indexs.sort()
			dict.pentahex.index.append(indexs)
		
		for felsen in arr.felsen:
			dict.pentahex.rotate[felsen.num.index] = {}
			
			for _i in range(1,6,1):
				dict.pentahex.rotate[felsen.num.index][_i] = []
				
				for stein in felsen.arr.stein:
					var clockwise = stein
					
					for _j in _i:
						clockwise = clockwise.dict.rotate["clockwise"]
					
					dict.pentahex.rotate[felsen.num.index][_i].append(clockwise.num.index)
				
				dict.pentahex.rotate[felsen.num.index][_i].sort()
				var indexs = dict.pentahex.rotate[felsen.num.index][_i]
				
				if !dict.pentahex.index.has(indexs):
					dict.pentahex.index.append(indexs)
				else:
					print(felsen.arr.index,_i, indexs)


	func pinch_indexs(indexs_: Array) -> Array:
		var indexs = []
		var directions = [0,4,5]
		var opportunity = {}
		
		for direction in directions:
			opportunity[direction] = []
		
		for index in indexs_:
			var stein = get_stein_by_index(index)
		
			for direction in directions:
				var neighbor_grid = stein.vec.grid+Global.dict.neighbor.hex[stein.num.parity][direction]
				
				if check_grid_on_berggipfel(neighbor_grid):
					var index_ = arr.stein[neighbor_grid.y][neighbor_grid.x].num.index
					opportunity[direction].append(index_)
		
		for direction in directions:
			if opportunity[direction].size() != indexs_.size():
				opportunity.erase(direction)
		
		return indexs


	func draw_felsen() -> void:
		num.felsen = 1#(arr.felsen.size()-1)%arr.felsen.size()
		var felsen = arr.felsen[num.felsen]
		
		for steins in arr.stein:
			for stein in steins:
				stein.flag.felsen = false
				stein.scene.myself.update_color()
		
		for index in felsen.arr.index:
			var stein = get_stein_by_index(index)
			stein.flag.felsen = true
			stein.scene.myself.update_color()


	func get_stein_by_index(index_: int) -> Classes_1.Stein:
		var x = index_%Global.num.size.berggipfel.col
		var y = index_/Global.num.size.berggipfel.col
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
