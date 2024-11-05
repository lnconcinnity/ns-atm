## this tests the program
extends Control

@onready var base_label: Label
@onready var output_lines := $Output/Lines

var all_tests_passed: bool = true


func _ready() -> void:
	var sample_label = $Output/Lines/SampleLabel
	base_label = sample_label.duplicate()
	sample_label.queue_free()
	
	audr_print("Welcome to the challenge checker! Gonna test your Godot code :)")
	audr_print("Creating test environment...")
	TestService.create()

	audr_print("Running tests...\n\n")
	run_tests.call_deferred()

	if all_tests_passed:
		audr_print.call_deferred("\nALL TESTS PASSED! CONGRATULATIONS! CHALLENGE COMPLETED!\n- Audr <3")


## The Tests

func run_tests() -> void:
	test("identifies 378282246310005 as AMEX").run("378282246310005").check("AMEX")
	test("identifies 371449635398431 as AMEX").run("371449635398431").check("AMEX")
	test("identifies 5555555555554444 as MASTERCARD").run("5555555555554444").check("MASTERCARD")
	test("identifies 5105105105105100 as MASTERCARD").run("5105105105105100").check("MASTERCARD")
	test("identifies 4111111111111111 as VISA").run("4111111111111111").check("VISA")
	test("identifies 4012888888881881 as VISA").run("4012888888881881").check("VISA")
	test("identifies 4222222222222 as VISA").run("4222222222222").check("VISA")
	test("identifies 1234567890 as INVALID (invalid length, checksum, identifying digits)").run("1234567890").check("INVALID")
	test("identifies 369421438430814 as INVALID (invalid identifying digits)").run("369421438430814").check("INVALID")
	test("identifies 5673598276138003 as INVALID (invalid identifying digits)").run("5673598276138003").check("INVALID")
	test("identifies 4111111111111113 as INVALID (invalid checksum)").run("4111111111111113").check("INVALID")
	test("identifies 4222222222223 as INVALID (invalid checksum)").run("4222222222223").check("INVALID")
	test("identifies 3400000000000620 as INVALID (AMEX identifying digits, VISA/Mastercard length)").run("3400000000000620").check("INVALID")
	test("identifies 430000000000000 as INVALID (VISA identifying digits, AMEX length)").run("430000000000000").check("INVALID")


## some other functions

func test(description: String) -> TestService.Test:
	var t := TestService.Test.new(description)
	t.stdout = test_print
	return t


func audr_print(text: String, color: Color = Color.WHITE) -> void:
	var new_label := base_label.duplicate()
	new_label.text = text
	new_label.add_theme_color_override("font_color", color)
	output_lines.add_child(new_label)


func test_print(finished_test: TestService.Test) -> void:
	if finished_test.passed:
		var color := Color8(75, 181, 67)
		audr_print(":) %s" % [finished_test.description], color)
		
	else:
		all_tests_passed = false

		var color := Color8(252, 16, 13)
		var expected_output: String = "expected \"%s\", not \"%s\"" % [finished_test.expected, finished_test.result]
		audr_print(":( %s\n     %s" % [finished_test.description, expected_output], color)



func _on_exit_button_pressed() -> void:
	TestService.reset()
	get_tree().change_scene_to_file("res://scenes/menu/main.tscn")
