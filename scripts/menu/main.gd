## The main part of the whole app
extends Control

## Variables, you don't need to touch these
@onready var card_input: LineEdit = $CardInput
@onready var output: Label = $Output


# TODO: This is the main function you will modify.
# This function is executed when the 'Verify Card' button is pressed.
# You can display output with `set_output()` like `print()` in Python or `System.out.println` in Java.
func verify_card() -> void:
	pass


# Also feel free to make your own functions here but
# but don't touch the other ones created already






## ----- !!! WARNING !!! -----
## Don't touch anything below here
## Go back up there

## Displays `text` in the $Output node
func set_output(text: String) -> void:
	output.text = text
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
