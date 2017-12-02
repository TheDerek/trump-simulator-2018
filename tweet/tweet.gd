extends CanvasLayer

var tweets = ["h, h,'';#; Charles McCullough, the respected fmr Intel Comm Inspector General, said public was misled on Crooked Hillary Emails. “Emails endangered National Security.” Why aren’t our deep State authorities looking at this? Rigged & corrupt? @TuckerCarlson @seanhannity"]
var words = []
var word = ''
var letter_pos = 0
var word_pos = -1
var tweet_pos = -1
onready var typed_word = ''
onready var label = get_node('label')

func _ready():
	get_next_tweet()
	get_next_word()

func get_next_tweet():
	tweet_pos += 1
	var text = tweets[tweet_pos]
	label.set_text(text)

	words = text.to_lower().split(' ')

func get_next_word():
	word_pos += 1
	word = words[word_pos]
	word.erase(0, ',')
	letter_pos = 0
	print('Fetched the next word: ' + word)

func get_char(key):
	return PoolByteArray([key]).get_string_from_utf8()

func is_word_completed():
	return letter_pos >= word.length()

func _input(event):
	if !(event is InputEventKey):
		return

	if event.is_pressed():
		return

	var key = event.get_scancode_with_modifiers()

	if is_word_completed():
		print('Word completed, cannot type anymore!')
		if key == KEY_SPACE:
			get_next_word()
		return

	#if  key < 65 or key > 90:
	#	return

	var letter = get_char(key).to_lower()
	print('Typed: ' + letter)

	if word[letter_pos] == letter:
		letter_pos += 1
		print(word.substr(0, letter_pos) + ' [' + word + '] ' + '(' + str(letter_pos) + ')')
		return