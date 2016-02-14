function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function msd_exists()
  local song = GAMESTATE:GetCurrentSong()
  if song == nil then
	return false
  end
  local chart = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
  return FILEMAN:DoesFileExist(song:GetSongDir().."msd/"..chart)
end

function GetMsdData(x)
  local sg = tostring(x)
  
  local s = GAMESTATE:GetCurrentSong()
  local c = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
  local p = tostring(s:GetSongDir().."msd/"..c.."/msd.txt")
  local f = RageFileUtil.CreateRageFile()
  
  if not f:Open(p,1) then
	f:destroy()
	return nil
	end
	
	local d = f:Read()
	f:Close()
	f:destroy()
    
  local rate = getrate()
  
  if sg == "V" then
	local v = string.sub(d,string.find(d,sg)+1,string.find(d,sg)+4)
	return v
  end
  
  if sg == "ovr" then
	local ovr = string.sub(d,string.find(d,sg)+3,string.find(d,sg)+6)
	return ovr
  end
  
  s = string.find(d,"R_"..rate.."_SG_"..sg)
  local f = string.find(d,":",s)-1
  o = string.sub(d,s,f)
  return o 
end

function getrate ()
  local rate = GAMESTATE:GetSongOptions('ModsLevel_Song')
  if rate == "" then
    rate = "1"
  end
  if rate == "2.0xMusic" then
  rate = "2"
  end
  rate = string.gsub(rate,"xMusic","")
  return rate
end