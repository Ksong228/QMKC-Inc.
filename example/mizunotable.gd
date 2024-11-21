extends Node3D

var card_database = UnoCards.new()

var suits = [
	UnoCards.Suit.RED,
	UnoCards.Suit.BLUE,
	UnoCards.Suit.GREEN,
	UnoCards.Suit.YELLOW
]

var ranks = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

var suit_index = 0
var rank_index = 0
var playerturn = 1

@onready var hand: CardCollection3D = $DragController/Hand
@onready var pile: CardCollection3D = $DragController/TableCards
@onready var player1: CardCollection3D = $DragController/Player1
@onready var player2: CardCollection3D = $DragController/Player2
@onready var player3: CardCollection3D = $DragController/Player3
@onready var player4: CardCollection3D = $DragController/Player4

func _input(event):
	if event.is_action_pressed("ui_down"):
		add_card()
	elif pile.card_layout_strategy is LineCardLayout:
		pile.card_layout_strategy = PileCardLayout.new()
	elif hand.card_layout_strategy is LineCardLayout:
		pile.card_layout_strategy = PileCardLayout.new()
	elif event.is_action_pressed("ui_up"):
		remove_card()
	elif event.is_action_pressed("ui_left"):
		clear_cards()


func instantiate_uno_card(rank, suit) -> UnoCard3D:
	var scene = load("res://example/uno_card_3d.tscn")
	var uno_card_3d: UnoCard3D = scene.instantiate()
	var card_data: Dictionary = card_database.get_card_data(rank, suit)
	uno_card_3d.rank = card_data["rank"]
	uno_card_3d.suit = card_data["suit"]
	uno_card_3d.front_material_path = card_data["front_material_path"]
	uno_card_3d.back_material_path = card_data["back_material_path"]
	
	return uno_card_3d

func add_card():
	var data = next_card()
	var card = instantiate_uno_card(data["rank"], data["suit"])
	
	match playerturn:
		1:
			player1.append_card(card)
			card.global_position = $"../Deck".global_position
		2:
			player2.append_card(card)
			card.global_position = $"../Deck".global_position
		3:
			player3.append_card(card)
			card.global_position = $"../Deck".global_position
		4:
			player4.append_card(card)
			card.global_position = $"../Deck".global_position
	next_turn()

func next_turn():
	playerturn += 1
	if playerturn > 4:
		playerturn = 1

func next_card():
	var suit_index = randi() % suits.size()
	var rank_index = randi() % ranks.size()
	var suit = suits[suit_index]
	var rank = ranks[rank_index]
	
	return {"suit": suit, "rank": rank}


func remove_card():
	if hand.cards.size() == 0:
		return
	
	var random_card_index = randi() % hand.cards.size()
	var card_to_remove = hand.cards[random_card_index]
	
	play_card(card_to_remove)


func play_card(card):
	var card_index = hand.card_indicies[card]
	var card_global_position = hand.cards[card_index].global_position
	var c = hand.remove_card(card_index)
	
	pile.append_card(c)
	c.remove_hovered()
	c.global_position = card_global_position
	


func clear_cards():
	var hand_cards = hand.remove_all()
	var pile_cards = pile.remove_all()
	
	for c in hand_cards:
		c.queue_free()
	
	for c in pile_cards:
		c.queue_free()


func _on_face_card_3d_card_3d_mouse_up():
	add_card()
