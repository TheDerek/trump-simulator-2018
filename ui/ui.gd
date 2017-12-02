extends CanvasLayer

onready var tweets = {}
var widgets = []
var markers = []

func _ready():
	var tweet_names = ['putin', 'hillary', 'science']

	#for name in tweet_names:
	#for i in range(0, tweet_names.size()):
	var name = 'putin'
	var file = File.new()
	file.open('res://ui/tweets_' + name + '.csv', File.READ)
	var lines = file.get_as_text().split("\n")
	tweets[name] = lines

	name = 'hillary'
	file = File.new()
	file.open('res://ui/tweets_' + name + '.csv', File.READ)
	lines = file.get_as_text().split("\n")
	tweets[name] = lines

	name = 'science'
	file = File.new()
	file.open('res://ui/tweets_' + name + '.csv', File.READ)
	lines = file.get_as_text().split("\n")
	tweets[name] = lines

	widgets = [get_node('panel/tweet_0'), get_node('panel/tweet_1'), get_node('panel/tweet_2')]
	markers = [get_node('marker_0'), get_node('marker_1'), get_node('marker_2')]
	assign_tweets()

	global.connect('selected', self, 'change_selected')
	global.connect('shuffle_tweets', self, 'assign_tweets')
	pass

func change_selected(index):
	for marker in markers:
		marker.hide()

	markers[index].show()

func shuffleList(list):
    randomize()
    var shuffledList = []
    var indexList = range(list.size())
    for i in range(list.size()):
        var x = randi()%indexList.size()
        shuffledList.append(list[indexList[x]])
        indexList.remove(x)
    return shuffledList

func get_random_element(list):
	randomize()
	var i = randi()%list.size();
	return list[i]

func assign_tweets():
	widgets = shuffleList(widgets)
	widgets[0].get_node('text').set_text(get_random_element(tweets['putin']))
	widgets[1].get_node('text').set_text(get_random_element(tweets['hillary']))
	widgets[2].get_node('text').set_text(get_random_element(tweets['science']))

	global.topics = {
		widgets[0].index: 'putin',
		widgets[1].index: 'hillary',
		widgets[2].index: 'science'
	}
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
