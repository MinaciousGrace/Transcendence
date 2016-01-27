local update = false

local widthmult = 283
local t = Def.ActorFrame{
	BeginCommand=cmd(queuecommand,"Set");
	OffCommand=cmd(bouncebegin,0.2;xy,-500,0;diffusealpha,0;); -- visible(false) doesn't seem to work with sleep
	OnCommand=cmd(bouncebegin,0.2;xy,0,0;diffusealpha,1;);
	SetCommand=function(self)
		self:finishtweening()
		if getTabIndex() == 0 then
			self:queuecommand("On");
			update = true
		else 
			self:queuecommand("Off");
			update = false
		end;
	end;
	TabChangedMessageCommand=cmd(queuecommand,"Set");
	PlayerJoinedMessageCommand=cmd(queuecommand,"Set");
};

local function split(str, pat)
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

local function GetMADS(x)
  local s = GAMESTATE:GetCurrentSong()
  p = tostring(s:GetSongFilePath())
  local f = RageFileUtil.CreateRageFile()
  if not f:Open(p,1) then
		f:destroy()
		return nil
	end
	
    local sm = f:Read()
    f:Close()
    f:destroy()
        
    local pos = string.find(sm,"MADALG")
    if pos ~= nil then
      sm = string.sub(sm,(pos+7))
      pos2 = string.find(sm,":")
      mads = split(string.sub(sm,1,pos2-1),"%,")
    else
    if x==1 then
      return ""
      else
      return 0
      end
   end
   return mads[x]
end

t[#t+1] = LoadFont("Common Large") .. {
	Name="MADSDiff";
	InitCommand=cmd(xy,(capWideScale(get43size(384),384)-266),SCREEN_BOTTOM-203;visible,true;halign,0;zoom,0.55;maxwidth,capWideScale(get43size(360),360)/capWideScale(get43size(0.45),0.45));
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
        local diff = GetMADS(1)
        if diff == ""  then
          local stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
          local enabled = GAMESTATE:IsPlayerEnabled(PLAYER_1);
          if enabled and stepsP1 ~= nil then
            diff = stepsP1:GetMeter();
          end;
        end
        self:settext(diff)
				if tonumber(diff) < 15 then
          self:diffuse(getVividDifficultyColor('Difficulty_Beginner'))
        elseif tonumber(diff) < 22 then
          self:diffuse(getVividDifficultyColor('Difficulty_Easy'))
        elseif tonumber(diff) < 28 then
          self:diffuse(getVividDifficultyColor('Difficulty_Medium'))
        elseif tonumber(diff) < 33 then
          self:diffuse(getVividDifficultyColor('Difficulty_Hard'))
        else
          self:diffuse(getVividDifficultyColor('Difficulty_Challenge'))
        end;
			else
        self:settext("")
			end
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = Def.Quad{
	Name="MADSSpeed";
	InitCommand=cmd(xy,70,167;zoomto,100,10;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Easy');diffusealpha,0.65);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
        local speed = tonumber(GetMADS(2))
        self:zoomto(speed*widthmult,20)
			else
        self:zoomto(0,0)
			end
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] =	LoadFont("Common Large")..{
		InitCommand=cmd(xy,18,175;zoom,0.3;halign,0;maxwidth,160);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update then
			local song = GAMESTATE:GetCurrentSong()
				if song ~= nil then
					self:settext("Speed");
					self:diffusealpha(tonumber(GetMADS(2))*1000)
				else
					self:settext("");
				end;
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = Def.Quad{
	Name="MADSStam";
	InitCommand=cmd(xy,70,187;zoomto,100,10;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Hard');diffusealpha,0.65);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
        local speed = tonumber(GetMADS(3))
        self:zoomto(speed*widthmult,20)
			else
        self:zoomto(0,0)
			end
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] =	LoadFont("Common Large")..{
		InitCommand=cmd(xy,18,195;zoom,0.3;halign,0;maxwidth,160);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update then
			local song = GAMESTATE:GetCurrentSong()
				if song ~= nil then
					self:settext("Stamina");
					self:diffusealpha(tonumber(GetMADS(2))*1000)
				else
					self:settext("");
				end;
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = Def.Quad{
	Name="MADSAnchor";
	InitCommand=cmd(xy,70,207;zoomto,100,10;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Challenge');diffusealpha,0.65);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
        local speed = tonumber(GetMADS(4))
        self:zoomto(speed*widthmult,20)
			else
        self:zoomto(0,0)
			end
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] =	LoadFont("Common Large")..{
		InitCommand=cmd(xy,18,215;zoom,0.3;halign,0;maxwidth,160);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update then
			local song = GAMESTATE:GetCurrentSong()
				if song ~= nil then
					self:settext("Anchor");
					self:diffusealpha(tonumber(GetMADS(2))*1000)
				else
					self:settext("");
				end;
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = Def.Quad{
	Name="MADSJack";
	InitCommand=cmd(xy,70,227;zoomto,100,10;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Medium');diffusealpha,0.65);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
        local speed = tonumber(GetMADS(5))
        self:zoomto(speed*widthmult,20)
			else
        self:zoomto(0,0)
			end
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] =	LoadFont("Common Large")..{
		InitCommand=cmd(xy,18,235;zoom,0.3;halign,0;maxwidth,160);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update then
			local song = GAMESTATE:GetCurrentSong()
				if song ~= nil then
					self:settext("Jack");
					self:diffusealpha(tonumber(GetMADS(2))*1000)
				else
					self:settext("");
				end;
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = LoadFont("Common Large")..{
		InitCommand=cmd(xy,50,264;zoom,0.6;maxwidth,110/0.6;halign,0);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update then

			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t.InitCommand=cmd(SetUpdateFunction,Update);

return t