--Avatar frames which also includes current additive %score, mods, and the song stepsttype/difficulty.

local t = Def.ActorFrame{
	Name="Avatars";
};

local profileP1
local profileP2

local profileNameP1 = "No Profile"
local playCountP1 = 0
local playTimeP1 = 0
local noteCountP1 = 0

local profileNameP2 = "No Profile"
local playCountP2 = 0
local playTimeP2 = 0
local noteCountP2 = 0


local AvatarXP1 = 0
local AvatarYP1 = SCREEN_HEIGHT-50
local AvatarXP2 = SCREEN_WIDTH-50
local AvatarYP2 = SCREEN_HEIGHT-50

local function msd_exists()
  local song = GAMESTATE:GetCurrentSong()
  if song == nil then
	return false
  end
  local chart = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
  return FILEMAN:DoesFileExist(song:GetSongDir().."msd/"..chart)
end

local function GetMsdData(x)
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
  
  s = string.find(d,"R_"..rate.."_SG_"..sg)
  local f = string.find(d,":",s)-1
  o = string.sub(d,s,f)
  return o 
end


-- P1 Avatar
t[#t+1] = Def.Actor{
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			profileP1 = GetPlayerOrMachineProfile(PLAYER_1)
			if profileP1 ~= nil then
				profileNameP1 = profileP1:GetDisplayName()
				playCountP1 = profileP1:GetTotalNumSongsPlayed()
				playTimeP1 = profileP1:GetTotalSessionSeconds()
				noteCountP1 = profileP1:GetTotalTapsAndHolds()
			else 
				profileNameP1 = "Machine Profile"
				playCountP1 = 0
				playTimeP1 = 0
				noteCountP1 = 0
			end; 
			if profileNameP1 == "" then 
				profileNameP1 = "Machine Profile"
			end;
		else
			profileNameP1 = "No Player"
			playCountP1 = 0
			playTimeP1 = 0
			noteCountP1 = 0
		end;
	end;
}

-- P1
if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	t[#t+1] = Def.ActorFrame{
		Name="P1Avatar";
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if profileP1 == nil then
				self:visible(false)
			else
				self:visible(true)
			end;
		end;
		Def.Sprite {
			InitCommand=cmd(visible,true;halign,0;valign,0;xy,AvatarXP1,AvatarYP1;);
			BeginCommand=cmd(queuecommand,"ModifyAvatar");
			ModifyAvatarCommand=function(self)
				self:finishtweening();
				self:LoadBackground(THEME:GetPathG("","../"..getAvatarPath(PLAYER_1)));
				self:zoomto(50,50)
			end;	
		};
		
		LoadFont("Common Normal") .. {
			InitCommand=cmd(xy,AvatarXP1+52,AvatarYP1+7;halign,0;zoom,0.6;shadowlength,1;maxwidth,146;diffuse,getMainColor('positive');diffusealpha,0);
			BeginCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				self:settext(profileNameP1)
			end;
			JudgmentMessageCommand=cmd(queuecommand,"Set");
		};
		
		LoadFont("Common Large") .. {
			InitCommand=cmd(xy,AvatarXP1+143,AvatarYP1-6;halign,0;zoom,0.35;shadowlength,1;maxwidth,180/0.6);
			BeginCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				local temp1 = getCurScoreST(PLAYER_1,0)
				local temp2 = getMaxScoreST(PLAYER_1,0)
				temp2 = math.max(temp2,1)
				local text = string.format("%05.2f%%",math.floor((temp1/temp2)*10000)/100)
				self:settext(text)
			end;
			JudgmentMessageCommand=cmd(queuecommand,"Set");
		};


		LoadFont("Common Large") .. {
			InitCommand=cmd(xy,AvatarXP1+90,AvatarYP1+24;halign,0;zoom,0.45;shadowlength,1;maxwidth,120;diffuse,getMainColor('positive'));
			BeginCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
				local diff = getDifficulty(steps:GetDifficulty())
				self:settext(diff)
				self:diffuse(getDifficultyColor(GetCustomDifficulty(steps:GetStepsType(),steps:GetDifficulty())))
			end;
		};
		
		LoadFont("Common Large") .. {
			InitCommand=cmd(xy,AvatarXP1+52,AvatarYP1+28;halign,0;zoom,0.75;shadowlength,1;maxwidth,50;diffuse,getMainColor('positive'));
			BeginCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				local meter
				if msd_exists() then
					local ds = split(GetMsdData(93),"%,")
					meter = tonumber(ds[2])
				else
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
					meter = steps:GetMeter()
				end
				self:settext(meter)
				if meter < 15 then
					self:diffuse(getVividDifficultyColor('Difficulty_Beginner'))
				elseif meter < 22 then
					self:diffuse(getVividDifficultyColor('Difficulty_Easy'))
				elseif meter < 28 then
					self:diffuse(getVividDifficultyColor('Difficulty_Medium'))
				elseif meter < 33 then
					self:diffuse(getVividDifficultyColor('Difficulty_Hard'))
				else
					self:diffuse(getVividDifficultyColor('Difficulty_Challenge'))
				end;
			end;
		};

		LoadFont("Common Normal") .. {
			Name="P1AvatarOption";
			InitCommand=cmd(xy,AvatarXP1+91,AvatarYP1+39;halign,0;zoom,0.4;shadowlength,1;maxwidth,180/0.4;);
			BeginCommand=cmd(queuecommand,"Set");
			SetCommand=function(self)
				self:settext(GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptionsString('ModsLevel_Current'))
			end;
		};

	};
	
	t[#t+1] = Def.ActorFrame{
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,AvatarXP1+53,AvatarYP1+8;halign,0;zoom,0.5;shadowlength,1;maxwidth,180/0.4;);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			self:settextf("Judge: %d",GetTimingDifficulty())
		end;
    };
  };
end;

return t;