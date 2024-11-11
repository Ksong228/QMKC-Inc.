class_name FaceCards
extends Resource

enum Rank {
	TWO = 2,
	THREE = 3,
	FOUR = 4,
	FIVE = 5,
	SIX = 6,
	SEVEN = 7,
	EIGHT = 8,
	NINE = 9,
	ZERO = 0,
	REVERSE = 12,
	SKIP = 11,
	PLUSTWO = 10,
	ONE = 1
}

enum Suit {
	RED,
	BLUE,
	YELLOW,
	GREEN
}


var data: Dictionary = _generate_all_face_cards()

func get_card_data(rank: Rank, suit: Suit):
	var card_id = get_card_id(rank, suit)
	
	if data.has(card_id):
		return data[card_id]
	
	return null
	
func get_card_id(rank: Rank, suit: Suit) -> String:
	return str(rank) + " of " + str(suit)


func _generate_all_face_cards() -> Dictionary:
	var _data = {}
	
	for suit in Suit:
		for rank in Rank:
			var front_material = "res://assets/Cards/"+ "card_" + str(suit).to_lower() + "_" + str(Rank[rank]) + ".res"
			var back_material = "res://example/materials/card-back.tres"
			var card_data = {
			"rank": rank,
			"suit": suit,
			"front_material_path": front_material,
			"back_material_path": back_material
			}
			var card_id = get_card_id(Rank[rank], Suit[suit])
			_data[card_id] = card_data
			
	return _data
