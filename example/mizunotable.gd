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
var reverse = false

@onready var hand: CardCollection3D = $DragController/Hand
@onready var pile: CardCollection3D = $DragController/TableCards
@onready var player1: CardCollection3D = $DragController/Player1
@onready var player2: CardCollection3D = $DragController/Player2
@onready var player3: CardCollection3D = $DragController/Player3
@onready var player4: CardCollection3D = $DragController/Player4

func _ready():
	pile.card_layout_strategy = PileCardLayout.new()
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
	if reverse == false:
		playerturn += 1
		if playerturn > 4:
			playerturn = 1
	else:
		playerturn -= 1
		if playerturn < 1:
			playerturn = 4

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

func change_direction():
	if reverse:
		reverse = false
	else:
		reverse = true

func handle_card(card: UnoCard3D):
	if card.rank<10:
		next_turn()
		return
	elif card.rank == 10:
		next_turn()
		next_turn()
	
	elif card.rank == 11:
		change_direction()
		next_turn()
	
	elif card.rank == 12:
		next_turn()
		add_card()
		add_card()
		next_turn()
	
	else:
		print("unknown card")

func _on_face_card_3d_card_3d_mouse_up():
	add_card()


func _on_table_cards_card_added(card: Variant) -> void:
	handle_card(card)
