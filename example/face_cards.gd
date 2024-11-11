class_name FaceCards
extends Resource

enum Rank {
	TWO = 02,
	THREE = 03,
	FOUR = 04,
	FIVE = 05,
	SIX = 06,
	SEVEN = 07,
	EIGHT = 08,
	NINE = 09,
	ZERO = 00,
	REVERSE = 12,
	SKIP = 11,
	PLUSTWO = 10,
	ONE = 01
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
