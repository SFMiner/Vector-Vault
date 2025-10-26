Task: Create SequenceRecorder.tscn for recording transformation chains

Requirements:
- Create scenes/ui/SequenceRecorder.tscn
- Root node: Panel, anchors TOP_LEFT, size 250x400
- Child: VBoxContainer with margins:
  - Label "Sequence Recorder"
  - ScrollContainer:
	- VBoxContainer "StepList" for showing recorded steps
  - HBoxContainer:
	- Button "Clear"
	- Button "Execute"
- Create scenes/ui/SequenceRecorder.gd:
  - Extend Panel
  - Add signal execute_sequence(sequence: TransformationSequence)
  - Add var current_sequence: TransformationSequence = TransformationSequence.new()
  - Add var recording_enabled: bool = false
  - Add func enable_recording():
	- recording_enabled = true
	- Clear previous sequence
  - Add func record_step(type: String, params: Dictionary):
	- current_sequence.add_step(type, params)
	- Add label to StepList showing step notation
  - Add func _on_execute_pressed():
	- Emit execute_sequence(current_sequence)
  - Add func _on_clear_pressed():
	- Clear current_sequence and StepList

Technical constraints:
- Godot 4.5 .tscn and .gd format
- Use tabs for indentation
- Shows each step as it's recorded
- Can execute or clear sequence

Success criteria:
- Records each transformation as user performs them
- Displays sequence in readable notation
- Execute button runs entire sequence
