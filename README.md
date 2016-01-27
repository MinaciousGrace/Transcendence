Super credit goes to all the sm5 devs who actually added features worth using
Special super credit to ca25nada for hand holding me through dumb stuff

Transcendence is a simple adaptation of ca25nada's spawncamping-wallhack theme
that focuses on providing a minimalist and configureless interface geared purely
toward a gameplay-optimized setup

The following probably don't work and if they don't I don't care
- 2p play (certainly won't look nice, but probably also won't work)
- Net play (should be fine actually but ¯\_(?_?)_/¯)
- widescreen; 4:3 is now the default and only supported aspect ratio



v1.1

- switched to 4:3 aspect ratio layout default, it's just more sensible for gameplay/streaming layouts
- merged in ca25nada's bugfixes/updates to the error bar
- wrote in scripts for pulling MADS data from .sm files, functionally working but still very rough
- updated defaults to better reflect optimized gameplay consult the prefoverride script for details
- this version will force reset game preferences (not theme preferences and hopefully never again)


v1.0

Color/Presentation---- 
Overall: Important stuff = biggger. Not important stuff = smaller/removed

- Main:positive is now used almost universally for theme element text (not "read-y" text)
- Main:frames darkened to nearly black
- Gutted nearly all the "glow and glitter" from the original theme
- Removed nearly all redundancies in data display produced by allowing for 2player modes
- Importance of data displayed is now reflected in the size/location of the display

Options/Preferences----
Overall: Defaults set to the settings that "competitive" players generally use

Preferences.ini stuff
***the PrefsOverride.lua file in the scripts folder will autoset these prefs upon theme initialization
- BGBrightness to 0
- Center1Player to 1
- DelayedBack to 0
- MaxHighScoresPerListForPlayer to 10
- ShowCaution to 0
- ShowDanger to 0
- ShowInstructions to 0
- SoundDrivers to "WaveOut"
if you want to manually set one/ all of these, delete the settings in the .lua or delete the script entirely

Gameplay/player options stuff
- DP set as the default scoring type
- Scoretracking enabled by default to 93% DP
- NPS graph/display enabled by default
- CB highlight enabled by default but modified to cover from the top of the screen to the receptors only
- Error bar enabled by default but relocated to just under the combo display for "ease of access"
- Combo moved slightly to the right to more evenly distribute numbers between both sides of the notefield
- Cmod increments changed to 50/1 default
- Default mini size set to 29% and removed the excessive number of options, set custom values in metrics if you want to (default remains no mini though)
- Reorganized rates, standard 1-2 at 0.1 increments are accessed by scrolling to the right, and 0.05 increments are left

Other stuff----
stuff

eval screen needs the most work atm