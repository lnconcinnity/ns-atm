## The main part of the whole app
extends Control

## Variables, you don't need to touch these
@onready var card_input: LineEdit = $CardInput
@onready var output: Label = $Output


# TODO: This is the main function you will modify.
# This function is executed when the 'Verify Card' button is pressed.
# You can display output with `set_output()` like `print()` in Python or `System.out.println` in Java.
func verify_card() -> void:
	var total = 0;
	var len = card_input.text.length();
	for i in range(len - 1, -1, -1):
		var twice = (len - 1 - i) % 2 == 1;
		var num = int(card_input.text[i]) * (2 if twice else 1);
		if twice and num > 9:
			num -= 9;
		total += num;
	var check = total % 10 == 0
	if check:
		if check_card_type(["4"], -1, Array(), [13, 16]):
			set_output("visa");
		elif check_card_type(["5"], 2, [51, 55]) or check_card_type(["2"], 4, [2221, 2720]):
			set_output("mastercard");
		elif check_card_type(["34", "37"], -1, Array(), [15]):
			set_output("amex");
		elif check_card_type(["6011", "65"]) or check_card_type(Array([]), 3, [644, 649]) or check_card_type(Array([]), 6, [622126, 622925]):
			set_output("discover");
		else:
			set_output('invalid');
	else:
		set_output('invalid');

func check_card_type(beginsIn: Array = Array([]) as Array[String], minLength: int = -1, prefixRange: Array = Array([-1, 1]), lengthRange: Array = Array([]) as Array[int]) -> bool:
	var text = card_input.text;
	if minLength > 0:
		if text.length() < minLength:
			return false;
		if prefixRange.size() > 0:
			var prefix = int(text.substr(0, minLength));
			if prefix < prefixRange[0] or prefix > prefixRange[1]:
				return false;
	
	if lengthRange.size() > 0:
		if text.length() not in lengthRange:
			return false;
	
	var space = beginsIn.size()
	if space > 0:
		var oks = 0;
		for beginsWith in beginsIn:
			if text.begins_with(beginsWith):
				oks += 1;
			
		return oks > 0;
	return true

# Also feel free to make your own functions here but
# but don't touch the other ones created already






## ----- !!! WARNING !!! -----
## Don't touch anything below here
## Go back up there

## Displays `text` in the $Output node
func set_output(text: String) -> void:
	text = text.to_upper();
	output.text = text;
	output.show()
	$OutputTimer.start()

	# very important do not touch!
	TestService.output = text


## Functions for signals

## This function is executed when the 'Verify Card' button is pressed
func _on_verify_button_button_up() -> void:
	verify_card()


func _on_dev_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/test_scene.tscn")


func _on_output_timer_timeout() -> void:
	output.hide()
