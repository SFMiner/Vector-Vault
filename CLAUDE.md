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
