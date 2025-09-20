extends RichTextLabel

var default_text:String = "High Score: "

func _process(delta):
	var text = str(default_text, str(Global.high_score))
	self.text = text
