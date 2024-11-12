class_name UnoCard3D
extends Card3D

@export var data: Dictionary:
	set(data):
		if data.has("rank"):
			rank = UnoCards.Rank[data["rank"]]
		
		if data.has("suit"):
			suit = UnoCards.Suit[data["suit"]]
		
		if data.has("front_material_path"):
			front_material_path = data["front_material_path"]
			
		if data.has("back_material_path"):
			back_material_path = data["back_material_path"]

@export var rank: UnoCards.Rank = UnoCards.Rank.ZERO
@export var suit: UnoCards.Suit = UnoCards.Suit.RED
@export var front_material_path: String:
	set(path):
		if path:
			var material = load(path)
			
			if material:
				$CardMesh/CardFrontMesh.set_surface_override_material(0, material)
		
@export var back_material_path: String:
	set(path):
		if path:
			var material = load(path)
			
			if material:
				$CardMesh/CardBackMesh.set_surface_override_material(0, material)


func _to_string():
	return str(rank) + " of " + str(suit)
