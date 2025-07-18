# powermate-scroller-mac

This app allows me to use my Griffin Powermate as a scroll device on Mac. Tested on an M3 device with MacOS Sequoia 15.5.

Build:
```
make
# This will produce a PowerMaterScroll.app that you can drag to your Applications directory.
```

You will need to go to Settings -> Privacy & Security -> Accessibility -> Press the little + icon and add PowerMateScroll.app.

Same in Settings -> Privacy & Security -> Input Monitoring.

You will need to remove it and re-add it both places after every time you rebuild.
