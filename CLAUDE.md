# VectorVault Project Coding Guidelines

## GDScript Type Inference

**Issue:** Godot cannot infer variable types if the value doesn't have a set type.

**Rule:** If using `:=` operator without an explicit type annotation, the assignment will fail with a type inference error.

**Solution:** Use one of these approaches:

1. **Explicit type with `:=`** (preferred when type is clear):
   ```gdscript
   var initial_offset: Vector2 := target.global_position - anchor_point
   ```

2. **No type annotation with `=`** (when type is inferred from context):
   ```gdscript
   var initial_offset = target.global_position - anchor_point
   ```

**DO NOT use `:=` without explicit type annotation** - leave out the colon if you're not specifying the type.

Example from Rotation.gd:
- ❌ `var initial_offset := target.global_position - anchor_point` (error)
- ✓ `var initial_offset: Vector2 := target.global_position - anchor_point` (correct)
- ✓ `var initial_offset = target.global_position - anchor_point` (also correct)

## Godot Rotation Direction Convention

**In Godot's coordinate system:**
- **Positive angles = Counter-clockwise rotation**
- **Negative angles = Clockwise rotation**

Example:
- `rotation_degrees = 90` rotates 90° counter-clockwise
- `rotation_degrees = -90` rotates 90° clockwise

## Control Node Anchoring (Godot 4.5)

**Issue:** Setting anchors_preset to anything other than FullRect or Custom (-1) causes Control nodes to disappear/become invisible, regardless of size settings.

**Solution:** Use Custom anchoring with explicit offsets:
```
anchors_preset = -1
anchor_left = 0.0
anchor_top = 0.0
anchor_right = 0.0
anchor_bottom = 0.0
offset_left = -40.0    (negative half-width)
offset_top = -40.0     (negative half-height)
offset_right = 40.0    (positive half-width)
offset_bottom = 40.0   (positive half-height)
```

This creates an 80×80 control centered at (0,0) relative to its parent.
