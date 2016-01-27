-- THESE WILL OVERRIDE SETTINGS IN PREFERENCES.INI UPON THEME INITIALIZATION

-- someone please explain to me why this is the only way that works
if themeConfig:get_data().global.Transcended == 0 then
PREFSMAN:SetPreference("DelayedBack",doot)
PREFSMAN:SetPreference("ShowCaution",doot)
PREFSMAN:SetPreference("ShowDanger",doot)
PREFSMAN:SetPreference("ShowInstructions",doot)
end

if themeConfig:get_data().global.Transcended == 0 then
PREFSMAN:SetPreference("BGBrightness",0)
PREFSMAN:SetPreference("Center1Player",1)
PREFSMAN:SetPreference("MaxHighScoresPerListForPlayer",10)
PREFSMAN:SetPreference("SoundDrivers","WaveOut")
PREFSMAN:SavePreferences()
themeConfig:get_data().global.Transcended = 1
themeConfig:set_dirty()
themeConfig:save()
end


