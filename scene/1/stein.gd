extends Polygon2D


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	var x = parent.vec.grid.x*Global.num.size.stein.r*2
	var y = parent.vec.grid.y*Global.num.size.stein.R*1.5
	
	if parent.num.parity == 1:
		x += Global.num.size.stein.r
	
	var offset_ = Vector2(Global.num.size.stein.r,Global.num.size.stein.R)
	position = Vector2(x,y)+offset_
	visible = false
	set_vertexs()
	update_color()
	var index = Global.num.size.berggipfel.col*parent.vec.grid.y+parent.vec.grid.x
	$Label.text = str(index)


func update_color() -> void:
	var max_h = 360.0
	var h = float(parent.vec.grid.y*Global.num.size.berggipfel.row+parent.vec.grid.x)/(Global.num.size.berggipfel.row*Global.num.size.berggipfel.col)
	var s = 0.25
	var v = 1
	
	if parent.flag.felsen:
		s = 1
	
	var color_ = Color.from_hsv(h,s,v)
	set_color(color_)


func set_vertexs() -> void:
	var order = "even"
	var corners = 6
	var r = Global.num.size.stein.R
	var vertexs = []
	
	for corner in corners:
		var a = Global.dict.corner.vector
		var vertex = Global.dict.corner.vector[corners][order][corner]*r
		vertexs.append(vertex)
	
	set_polygon(vertexs)
