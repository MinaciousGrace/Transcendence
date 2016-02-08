Super credit goes to all the sm5 devs who actually added features worth using
Special super credit to ca25nada for hand holding me through dumb stuff

Transcendence is a simple adaptation of ca25nada's spawncamping-wallhack theme
that focuses on providing a minimalist and configureless interface geared purely
toward a gameplay-optimized setup

The following are not supported to varying degrees of breaky-ness:

- Any version of sm5 older than 5.0.10
- Any aspect ratio other than 4:3
- 2player
- Net play
- Courses, casseroles, lasagna etc

Known issues/bugs

- Loaded graphs from the msd tab will stay in the game memory until it overflows and crashes.
This isn't a particularly big deal unless you scroll through every song with msd data while 
on the msd graphs tab. Which you shouldn't be doing anyway. My guess is the text data also
isn't destroyed and stays in memory but this is far less concerning (probably?).
- The "technical" meter bar is a mess right now. In its current incarnation it essentially functions 
as a shitty "jack" meter that doubles as an equally shitty "anchor-y" meter. It currently does not
factor in how manipulatable patterns present in the file are, which is its primary purpose.
- The "jack" meter is disabled until I write explicit jack sequence detection, for now the "technical"
meter will suffice
- Gameplay and evaluation screens haven't been touched nearly at all since initial release (they're up next)
- The MSD system currently does not support 1.x5 rates. This is not difficult to implement but it's not a 
high priority. 
- Changing the rate (music speed) while in music select will only carry over into gameplay if the options menu
is not entered. If the options menu is entered your rate will be reset to the rate of the last played song. 
- There's no documentation on the MSD system yet. If you don't understand it, don't use it. 


v1.2

- Rewrote all the scripts for pulling msd data
- For now the currently available msd data packs will be packaged with the theme download 
- Merged in ca25nada's simfile tab updates (cuz it was effortless)
- Reinstated Captain General 21 mini options. Default mini mod upon theme installation is now 0 again. 
If you wish to set a default value it is most efficiently done from the Preferences.ini file under Game-Dance.
- Added 0.9-0.7 rates. They are accessible after scrolling left (the 0.05 increments) beyond 1.95x, or right
(the 0.1 increments) beyond 2.0x
- Rate (music speed) can now be changed from music select. Msd data display will update to match rate selected.
There's a minor bug with this documented in the bugs section.



v1.1

- switched to 4:3 aspect ratio layout default, it's just more sensible for gameplay/streaming layouts
- merged in ca25nada's bugfixes/updates to the error bar
- wrote in scripts for pulling msd data from .sm files, functionally working but still very rough
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