Task: Create World_4_Level_3.tscn - multi-object combination puzzle

Before you begin enacting this prompt, ask me whether extended thinking is turned on.  (Tell me it should be ON!)

Requirements:
- Create scenes/levels/world_4_architects_vault/World_4_Level_3.tscn
- Root node: Node2D named "World_4_Level_3", attach BaseLevel.gd
- Set exports: level_name = "Vault 4-3 - Architect's Challenge", world_number = 4, level_number = 3
- Children:
  - Player at position (150, 500)
  - StaticBody2D "Floor": multi-platform layout
  - GeoBlock "Block1" at (250, 450)
  - GeoBlock "Block2" at (350, 450)
  - GeoBlock "Block3" at (450, 450)
  - Sprite2D "GhostOutline1" at (500, 350) with rotation/scale
  - Sprite2D "GhostOutline2" at (600, 350) with rotation/scale
  - Sprite2D "GhostOutline3" at (700, 350) with rotation/scale
  - Anchor "Pivot1" at (550, 400)
  - PressurePlate at (750, 492)
  - Door blocking final goal
  - SequenceRecorder instance
  - Label "Hint" at (400, 250): "The ultimate test of mastery!"
- Add UI instances
- Script override in setup_level():
  - Multiple AlignmentConditions (one per block)
  - All blocks must match their outlines
  - Pressure plate must be activated
  - Completion requires perfect alignment of all three

Technical constraints:
- Godot 4.5 .tscn format
- Most complex puzzle in game
- Combines all mechanics: translation, rotation with anchors, scaling, weight
- Multiple objects to manipulate

Success criteria:
- All three blocks must reach targets
- Pressure plate activated by weight
- Door opens allowing access to final goal
- Demonstrates complete mastery of all transformations
