Task: Create World_4_Level_2.tscn - translation, rotation, and scaling

Requirements:
- Create scenes/levels/world_4_architects_vault/World_4_Level_2.tscn
- Root node: Node2D named "World_4_Level_2", attach BaseLevel.gd
- Set exports: level_name = "Vault 4-2", world_number = 4, level_number = 2
- Children:
  - Player at position (150, 500)
  - StaticBody2D "Floor": (400, 550) size 800x50
  - GeoBlock "KeyBlock" at (200, 500)
	- Initial scale (0.5, 0.5)
	- Initial rotation_degrees = 0
  - Sprite2D "GhostOutline" at (650, 400)
	- Modulate: Color(1, 1, 1, 0.3)
	- Set scale (1.5, 1.5)
	- Set rotation_degrees = 90
  - SequenceRecorder instance
  - Label "Hint" at (400, 300): "Use all three transformations!"
- Add UI instances
- Script override in setup_level():
  - Enable sequence recording
  - AlignmentCondition with stricter tolerances for position, rotation, AND scale
  - Requires: S(3.0) → T(+450, -100) → R(90°) or similar

Technical constraints:
- Godot 4.5 .tscn format
- All three transformations required
- Ghost outline shows complete target state
- Sequence matters less than final result

Success criteria:
- Block must match position, rotation, AND scale
- Recorder shows all three transformation types
- Teaches that transformations combine
- Level completes on perfect alignment
