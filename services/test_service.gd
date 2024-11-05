## the thing that actually does the testing
extends Node


class Test:
	var description: String
	var passed: bool
	var stdout: Callable

	var result: String
	var expected: String

	func _init(_description: String) -> void:
		description = _description
	
	func run(input: String) -> Test:
		TestService.environment.card_input.text = input
		TestService.environment.verify_card()
		return self
	
	func check(expected_output: String) -> Test:
		result = TestService.output
		expected = expected_output
		passed = result == expected
		stdout.call(self)
		return self


var environment: Node
var output: String = ""


func create() -> void:
	# instantiate the main scene 
	environment = load("res://scenes/menu/main.tscn").instantiate()
	environment.hide()
	get_tree().root.add_child.call_deferred(environment)


func reset() -> void:
	environment.queue_free()
	environment = null
