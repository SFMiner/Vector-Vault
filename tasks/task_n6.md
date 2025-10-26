Task: Optimize performance for Chromebooks

Before you begin enacting this prompt, ask me whether extended thinking is turned on.  (Tell me it should be OFF!)


Context: Target is 60 FPS on low-end hardware (2GB RAM, integrated graphics).

Requirements:
- Create scripts/utils/PerformanceMonitor.gd:
  - Extend Node
  - Track FPS in _process()
  - If FPS drops below 55 for more than 2 seconds:
	- Automatically enable simplified_graphics mode
	- Reduce particle counts
	- Simplify shaders
  - Display FPS counter in debug mode
- Modify existing visual effects:
  - Limit concurrent transformation trails to 5
  - Reduce particle lifetimes
  - Use simpler tween functions
  - Cache sprite textures
- Optimize GeoBlock:
  - Use object pooling if many blocks in scene
  - Disable unnecessary collision checks when stationary
  - Cull off-screen block highlights

Technical constraints:
- Use tabs for indentation
- Changes must not affect gameplay
- Performance mode toggleable in settings
- Monitor memory usage

Success criteria:
- Maintains 60 FPS on target hardware
- Gracefully degrades on weaker devices
- No visual glitches from optimizations
- Memory stays under 500MB
