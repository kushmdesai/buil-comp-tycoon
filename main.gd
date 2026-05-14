extends Node2D

const CELL_SIZE = 64
const COLS = 16
const ROWS = 10

func _draw():
	for x in range(COLS + 1):
		draw_line(
			Vector2(x * CELL_SIZE, 0),
			Vector2(x * CELL_SIZE, ROWS * CELL_SIZE),
			Color(0.4, 0.8, 1.0, 0.5),
			1.0
		)
		
	for y in range(COLS + 1):
		draw_line(
			Vector2(0, y * CELL_SIZE),
			Vector2(COLS * CELL_SIZE, y * CELL_SIZE),
			Color(0.4, 0.8, 1.0, 0.5),
			1.0
		)
	if hovered_cell.x >= 0 and hovered_cell.x < COLS and hovered_cell.y >= 0 and hovered_cell.y < ROWS:
		draw_rect(
			Rect2(hovered_cell.x * CELL_SIZE, hovered_cell.y * CELL_SIZE, CELL_SIZE, CELL_SIZE),
			Color(0.4, 0.8, 1.0, 0.2)
		)
		
var hovered_cell = Vector2i(-1, -1)

func _input(event):
	if event is InputEventMouseButton:
		hovered_cell = Vector2i(
			int(event.position.x / CELL_SIZE),
			int(event.position.y / CELL_SIZE)
		)
	queue_redraw()
