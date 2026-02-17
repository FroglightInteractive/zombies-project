extends Node

signal user_added(user_index: int)
signal user_removed(user_index: int)

# user_index is 0-3
# device is -1 for keyboard/mouse, 0+ for joypads

var user_data: Dictionary = {}
var _device_to_user_index_map: Dictionary = {}

const MAX_USERS = 8

func add_user(device_index: int) -> int:
	var user_index = get_next_free_user_index()
	if user_index >= 0:
		user_data[user_index] = {
			"user_index": user_index,
			"device_index": device_index,
			"supports_mouse": (device_index == -1), # This won't be true forever, but it's good enough for now
			"player": null,
		}
		_device_to_user_index_map[device_index] = user_index
		user_added.emit(user_index)
		return user_index
	return -1

func remove_user(user_index: int):
	if user_data.has(user_index):
		_device_to_user_index_map.erase(get_user_device_index(user_index))
		user_data.erase(user_index)
		user_removed.emit(user_index)

func get_user_count():
	return user_data.size()

func get_user_indexes():
	return user_data.keys()

func get_user_device_index(user_index: int) -> int:
	return get_user_data(user_index, "device_index")

func get_user_from_device_index(device_index: int) -> int:
	if not _device_to_user_index_map.has(device_index):
		return -1
	return _device_to_user_index_map[device_index]

func user_exists(user_index: int) -> bool:
	return user_data.has(user_index)
	

# get player data.
# null means it doesn't exist.
func get_user_data(user_index: int, key: StringName):
	if user_data.has(user_index) and user_data[user_index].has(key):
		return user_data[user_index][key]
	return null

# set player data to get later
func set_user_data(player: int, key: StringName, value: Variant):
	# if this player is not joined, don't do anything:
	if !user_data.has(player):
		return 
	
	user_data[player][key] = value

func is_device_joined(device: int) -> bool:
	for player_id in user_data:
		var d = get_user_device_index(player_id)
		if device == d: return true
	return false

# returns a valid player integer for a new player.
# returns -1 if there is no room for a new player.
func get_next_free_user_index() -> int:
	for i in MAX_USERS:
		if !user_data.has(i): return i
	return -1

# returns an array of all valid devices that are *not* associated with a joined player
func get_unjoined_devices():
	var devices = Input.get_connected_joypads()
	# also consider keyboard player
	devices.append(-1)
	
	# filter out devices that are joined:
	return devices.filter(func(device): return !is_device_joined(device))
	
# returns an array of all valid devices that are *not* associated with a joined player
func get_all_devices():
	var devices = Input.get_connected_joypads()
	# also consider keyboard player
	devices.append(-1)
	
	return devices



func assign_player_to_user(user_index: int, player: Player):
	user_data[user_index]["player"] = player

func remove_player_from_user(user_index: int):
	user_data[user_index]["player"] = null

func get_player(input_user: int) -> Player:
	return user_data[input_user]["player"]

####

func get_action_raw_strength(player_index: int, action: StringName, exact_match: bool = false) -> float:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.get_action_raw_strength(device, action, exact_match)

func get_action_strength(player_index: int, action: StringName, exact_match: bool = false) -> float:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.get_action_strength(device, action, exact_match)

func get_axis(player_index: int, negative_action: StringName, positive_action: StringName) -> float:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.get_axis(device, negative_action, positive_action)

func get_vector(player_index: int, negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName, deadzone: float = -1.0) -> Vector2:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.get_vector(device, negative_x, positive_x, negative_y, positive_y, deadzone)

func is_action_just_pressed(player_index: int, action: StringName, exact_match: bool = false) -> bool:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.is_action_just_pressed(device, action, exact_match)

func is_action_just_released(player_index: int, action: StringName, exact_match: bool = false) -> bool:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.is_action_just_released(device, action, exact_match)

func is_action_pressed(player_index: int, action: StringName, exact_match: bool = false) -> bool:
	var device = get_user_device_index(player_index)
	return MultiplayerInput.is_action_pressed(device, action, exact_match)
