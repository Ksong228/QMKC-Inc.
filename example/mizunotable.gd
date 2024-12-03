extends Node3D

var card_database = UnoCards.new()

var suits = [
	UnoCards.Suit.RED,
	UnoCards.Suit.BLUE,
	UnoCards.Suit.GREEN,
	UnoCards.Suit.YELLOW
]

var ranks = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

var playerturn = 0

@onready var hand: CardCollection3D = $DragController/Hand
@onready var pile: CardCollection3D = $DragController/TableCards
@onready var player1: CardCollection3D = $DragController/Player1
@onready var player2: CardCollection3D = $DragController/Player2
@onready var player3: CardCollection3D = $DragController/Player3
@onready var player4: CardCollection3D = $DragController/Player4

func _ready():
	start_game()
	deal_cards()

func start_game():
	playerturn = 0
	next_turn()
	
func deal_cards():
	for i in range(7):
		for player in [player1, player2, player3, player4]:
			var data = next_card()
			var card = instantiate_uno_card(data["rank"], data["suit"])
			player.append_card(card)
			card.global_position = $"../Deck".global_position

func is_current_player(player: CardCollection3D) -> bool:
	match playerturn:
		1:
			return player == player1
		2:
			return player == player2
		3:
			return player == player3
		4:
			return player == player4
	return false

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
	uno_card_3d.data = card_data
	return uno_card_3d

func add_card():
	if !is_current_player(player1) and !is_current_player(player2) and !is_current_player(player3) and !is_current_player(player4):
		print("It's not this player's turn.")
		return

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

func next_turn():
	# Switch to the next player's turn.
	playerturn += 1
	if playerturn > 4:
		playerturn = 1

	print("SSSSSSSSSSSSSSSSSSSSSSSSSSSS")
	print("It's Player %d's turn." % playerturn)
	match playerturn:
		1:
			pile.current_player = player1
		2:
			pile.current_player = player2
		3:
			pile.current_player = player3
		4:
			pile.current_player = player4

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
	# Ensure only the current player can play cards.
	var current_player
	match playerturn:
		1:
			current_player = player1
		2:
			current_player = player2
		3:
			current_player = player3
		4:
			current_player = player4

	if card not in current_player.cards:
		print("You cannot play this card. It's Player %d's turn." % playerturn)
		return

	var card_index = current_player.card_indicies[card]
	var card_global_position = current_player.cards[card_index].global_position
	var c = current_player.remove_card(card_index)
	
	pile.append_card(c)
	c.remove_hovered()
	c.global_position = card_global_position

	# Advance to the next turn after a card is played.
	next_turn()

func clear_cards():
	var hand_cards = hand.remove_all()
	var pile_cards = pile.remove_all()
	
	for c in hand_cards:
		c.queue_free()
	
	for c in pile_cards:
		c.queue_free()

func _on_face_card_3d_card_3d_mouse_up():
	add_card()


func _on_table_cards_card_added(card: Variant) -> void:
	next_turn()
