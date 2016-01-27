-- THESE WILL OVERRIDE SETTINGS IN PREFERENCES.INI UPON THEME INITIALIZATION

-- someone please explain to me why this is the only way that works
if themeConfig:get_data().global.Transcended == 0 or themeConfig:get_data().global.versupdate == 1 then
PREFSMAN:SetPreference("DelayedBack",doot)
PREFSMAN:SetPreference("ShowCaution",doot)
PREFSMAN:SetPreference("ShowDanger",doot)
PREFSMAN:SetPreference("ShowInstructions",doot)
end

if themeConfig:get_data().global.Transcended == 0 or themeConfig:get_data().global.versupdate == 1 then
PREFSMAN:SetPreference("BGBrightness",0)
PREFSMAN:SetPreference("Center1Player",1)
PREFSMAN:SetPreference("DisplayAspectRatio",1.333333)
PREFSMAN:SetPreference("DisplayHeight",768)
PREFSMAN:SetPreference("DisplayWidth",1024)
PREFSMAN:SetPreference("FastNoteRendering",1)
PREFSMAN:SetPreference("MaxHighScoresPerListForPlayer",10)
PREFSMAN:SetPreference("SoundDrivers","WaveOut")
PREFSMAN:SetPreference("SoundWriteAhead",1)
PREFSMAN:SetPreference("SoundPreloadMaxSamples",2048576)
PREFSMAN:SetPreference("VideoRenderers","d3d,opengl")
PREFSMAN:SavePreferences()
themeConfig:get_data().global.Transcended = 1
themeConfig:get_data().global.versupdate = 0
themeConfig:set_dirty()
themeConfig:save()
end


