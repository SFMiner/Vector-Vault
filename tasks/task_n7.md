Task: Configure HTML5 export settings

Before you begin enacting this prompt, ask me whether extended thinking is turned on.  (Tell me it should be ON!)


Manual steps (cannot be automated via Claude Code):

1. Open Godot Editor → Project → Export
2. Add "Web" export template
3. Configure settings:
   - Export Path: export/html5/index.html
   - Head Include: Add viewport meta tag for mobile
   - Progressive Web App: Enable
   - Icon: Set to game icon
4. Export Options:
   - Vram Texture Compression: Enabled
   - Thread Support: Disabled (for better browser compatibility)
   - GDExtension Support Level: None
5. Custom HTML Shell:
   - Modify index.html to include:
	 - Loading bar
	 - Fullscreen button
	 - Analytics export button
	 - Instructions text

Create export/html5/custom_shell.html with:
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
	<title>VectorVault</title>
	<style>
		body { margin: 0; background: #1a1a1a; }
		#canvas { display: block; margin: 0; color: white; }
		#status { color: #aaa; font-family: sans-serif; text-align: center; padding: 20px; }
	</style>
</head>
<body>
	<div id="status">Loading VectorVault...</div>
	<canvas id="canvas"></canvas>
	<script src="index.js"></script>
</body>
</html>
```

Success criteria:
- Exports cleanly without errors
- Loads in Chrome, Firefox, Safari
- Works on Chromebooks and tablets
- File size under 50MB
- Loads in under 5 seconds on decent connection
