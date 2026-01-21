@tool
@icon("../assets/closed_shape.png")
extends SS2D_Shape
class_name SS2D_Shape_Closed
# DEPRECATED: Use [SS2D_Shape] instead.

# ----------------------------------------------------
# UNUSED FUNCTIONS
# ----------------------------------------------------

# Returns true if line segment 'a1a2' and 'b1b2' intersect.
func do_edges_intersect(a1: Vector2, a2: Vector2, b1: Vector2, b2: Vector2) -> bool:
	var o1 := get_points_orientation(PackedVector2Array([a1, a2, b1]))
	var o2 := get_points_orientation(PackedVector2Array([a1, a2, b2]))
	var o3 := get_points_orientation(PackedVector2Array([b1, b2, a1]))
	var o4 := get_points_orientation(PackedVector2Array([b1, b2, a2]))

	# General case
	if o1 != o2 and o3 != o4:
		return true

	# Special cases
	if o1 == SS2D_Point_Array.ORIENTATION.COLINEAR and on_segment(a1, b1, a2):
		return true

	if o2 == SS2D_Point_Array.ORIENTATION.COLINEAR and on_segment(a1, b2, a2):
		return true

	if o3 == SS2D_Point_Array.ORIENTATION.COLINEAR and on_segment(b1, a1, b2):
		return true

	if o4 == SS2D_Point_Array.ORIENTATION.COLINEAR and on_segment(b1, a2, b2):
		return true

	return false


# ----------------------------------------------------
# LINE SEGMENT INTERSECTION
# ----------------------------------------------------
static func get_edge_intersection(
	a1: Vector2, a2: Vector2,
	b1: Vector2, b2: Vector2
) -> Variant:
	var den := (b2.y - b1.y) * (a2.x - a1.x) - (b2.x - b1.x) * (a2.y - a1.y)

	if den == 0.0:
		return null

	var ua := ((b2.x - b1.x) * (a1.y - b1.y) - (b2.y - b1.y) * (a1.x - b1.x)) / den
	var ub := ((a2.x - a1.x) * (a1.y - b1.y) - (a2.y - a1.y) * (a1.x - b1.x)) / den

	if ua < 0.0 or ua > 1.0 or ub < 0.0 or ub > 1.0:
		return null

	return a1 + ua * (a2 - a1)


# ----------------------------------------------------
# HELPER
# ----------------------------------------------------
static func on_segment(p: Vector2, q: Vector2, r: Vector2) -> bool:
	return (
		q.x <= max(p.x, r.x) and q.x >= min(p.x, r.x) and
		q.y <= max(p.y, r.y) and q.y >= min(p.y, r.y)
	)


func _enter_tree():
	if _renderer == null:
		_renderer = SS2D_Renderer.new(self)


func _ready():
	# Force one guaranteed build
	call_deferred("_force_initial_build")


func _force_initial_build():
	if not is_inside_tree():
		return
	_dirty = true
	force_update()
