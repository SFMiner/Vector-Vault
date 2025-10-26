TO CLAUDE: THIS IS A MANUAL TASK! IF I TELL YOU TO RUN IT AS A PROMPT, STOP HERE AND TELL ME THAT I HAVE MADE THIS ERROR! DO NOT ATTEMPT TO RUN THE TASK YOURSELF!

Create a testing checklist and verify all items:
markdown# VectorVault Final QA Checklist

## Core Mechanics
- [ ] Translation moves blocks correctly in all 4 directions
- [ ] Rotation works around object center
- [ ] Rotation works around external anchors
- [ ] Scaling increases/decreases size proportionally
- [ ] Ghost preview shows correct transformation
- [ ] Collision shapes update with scale changes

## UI/UX
- [ ] Radial menu opens on targeted block click
- [ ] All transformation inputs work correctly
- [ ] Preview updates in real-time
- [ ] Level complete panel shows accurate stats
- [ ] Pause menu pauses entire game
- [ ] Accessibility settings apply correctly
- [ ] Colorblind mode uses distinct colors
- [ ] Tutorial overlays appear correctly

## Levels
- [ ] All World 1 levels completable
- [ ] All World 2 levels completable
- [ ] All World 3 levels completable
- [ ] All World 4 levels completable
- [ ] Level progression unlocks correctly
- [ ] Completion conditions detect wins accurately
- [ ] No levels have impossible solutions

## Analytics
- [ ] All transformations recorded
- [ ] CSV export downloads correctly
- [ ] Data format is teacher-friendly
- [ ] Timestamps accurate
- [ ] Sequence notation correct

## Performance
- [ ] Maintains 60 FPS on Chromebook
- [ ] No memory leaks over 30 min session
- [ ] HTML5 export loads in <5 seconds
- [ ] Touch controls work on tablets
- [ ] No audio glitches

## Persistence
- [ ] Progress saves automatically
- [ ] Settings persist between sessions
- [ ] Analytics data preserved
- [ ] Load game restores correctly

## Accessibility
- [ ] Text readable at all sizes
- [ ] Colorblind mode colors distinguishable
- [ ] Coordinate display toggleable
- [ ] Simplified graphics improve performance
- [ ] Grid opacity adjustable

## Edge Cases
- [ ] Rapid transformation clicks handled
- [ ] Overlapping blocks don't glitch
- [ ] Player can't fall through moved blocks
- [ ] Negative translations work correctly
- [ ] 360° rotation handled properly
- [ ] Scale limits enforced (0.25x - 4x)
```

**Test procedure:**
1. Play through entire game start to finish
2. Try breaking each mechanic deliberately
3. Test on multiple browsers
4. Test on actual Chromebook if possible
5. Have 2-3 people from target audience playtest
```
