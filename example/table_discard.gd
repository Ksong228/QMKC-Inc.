class_name TableDiscard
extends CardCollection3D

var current_player: CardCollection3D

func can_insert_card(card: UnoCard3D, from_collection: CardCollection3D) -> bool:
		#print("\n________")
		#print("cardssize = ", cards.size())
		#print("Dragging Card: ", card)
		
		if from_collection != current_player:
			print("It's not this player's turn.")
			return false
		
		if cards.size() == 0:
			return true
		
		var last_card = cards[cards.size() - 1]
		var is_same_rank = (card.rank == last_card.rank)
		var is_same_color = last_card.suit == card.suit
		
		#print("lastCard: ", last_card)
		
		return is_same_color or is_same_rank
		
func can_reorder_card(_card: UnoCard3D) -> bool:
	return false


func can_remove_card(_card: UnoCard3D) -> bool:
	return false


func can_select_card(_card: UnoCard3D) -> bool:
	return false
