extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("timeline1")
	Dialogic.signal_event.connect(on_signal_event)
	Dialogic.timeline_started.connect(on_timeline_started)
	
func on_timeline_started() -> void:
	GameManager.fade()
	
func on_signal_event(stringSignal) -> void:
	if stringSignal == "on_ending":
		print("ending")
		
		var ending_dictionary = {
		"jenny": Dialogic.VAR.Jenny,
		"taylor": Dialogic.VAR.Taylor,
		"margie": Dialogic.VAR.Margie
		}
		var highest_value = ending_dictionary.values().max()
		print("Ending values: ", ending_dictionary)
		print("Highest value: ", highest_value)

		if highest_value == 0:
			print("No one wins")
		elif highest_value == ending_dictionary["jenny"]:
			print("Jenny wins")
			Dialogic.start("JennyEnding")
		elif highest_value == ending_dictionary["taylor"]:
			print("Taylor wins")
			Dialogic.start("TaylorEnding")
		elif highest_value == ending_dictionary["margie"]:
			print("Margie wins")
			Dialogic.start("MargieEnding")
	if stringSignal == "on_jenny_final":
		print("Jenny final")
	if stringSignal == "on_taylor_final":
		print("Taylor final")
	if stringSignal == "on_margie_final":
		print("Margie final")
