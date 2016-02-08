local update = false
local t = Def.ActorFrame{
	BeginCommand=cmd(queuecommand,"Set";visible,false);
	OffCommand=cmd(bouncebegin,0.2;xy,-500,0;diffusealpha,0;); -- visible(false) doesn't seem to work with sleep
	OnCommand=cmd(bouncebegin,0.2;xy,0,0;diffusealpha,1;);
	SetCommand=function(self)
		self:finishtweening()
		if getTabIndex() == 1 then
			self:queuecommand("On");
			self:visible(true)
			update = true
		else 
			self:queuecommand("Off");
			update = false
		end;
	end;
	TabChangedMessageCommand=cmd(queuecommand,"Set");
	PlayerJoinedMessageCommand=cmd(queuecommand,"Set");
};

local function msd_exists()
  local song = GAMESTATE:GetCurrentSong()
  if song == nil then
	return false
  end
  local chart = GAMESTATE:GetHardestStepsDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
  return FILEMAN:DoesFileExist(song:GetSongDir().."msd/"..chart)
end

local frameX = 10
local frameY = 45
local frameWidth = capWideScale(320,400)
local frameHeight = 350
local fontScale = 0.4
local distY = 100
local offsetX1 = 100
local offsetX2 = 10
local offsetY = 20

local stringList = {"Normalized Difficulty","Chord Density","Stamina Intensity"}

local function makeText(index)
	return LoadFont("Common Normal")..{
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+(index*distY)-75;zoom,fontScale;halign,0;maxwidth,offsetX1/fontScale);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
      if msd_exists() then
        self:settext(stringList[index])
      else
        self:settext("No msd data found.")
      end
		end;
		CodeMessageCommand=cmd(queuecommand,"Set");
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	};
end;

t[#t+1] = Def.Quad{
	InitCommand=cmd(xy,frameX,frameY;zoomto,frameWidth,frameHeight;halign,0;valign,0;diffuse,color("#333333CC"));
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
	end;
	CodeMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(xy,frameX,frameY;zoomto,frameWidth,offsetY;halign,0;valign,0;diffuse,getMainColor('frames');diffusealpha,0.5);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
	end;
	CodeMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = LoadFont("Common Normal")..{
	InitCommand=cmd(xy,frameX+5,frameY+offsetY-9;zoom,0.6;halign,0;diffuse,getMainColor('positive'));
	BeginCommand=cmd(settext,"MSD Info")
};


if GAMESTATE:GetNumPlayersEnabled() == 1 then
	local pn = GAMESTATE:GetEnabledPlayers()[1]
	local profile = GetPlayerOrMachineProfile(pn)

  t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+10;zoom,0.6;halign,0;maxwidth,offsetX1/fontScale);
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			if update and msd_exists() then
        local chart = string.gsub(GAMESTATE:GetHardestStepsDifficulty(),"Difficulty_","")
				self:settext(chart);
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
  };

	t[#t+1] = Def.Sprite {
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+32;diffusealpha,0.6;zoomy,0;sleep,0.5;decelerate,0.25;zoomy,1;halign,0;valign,0);
		Name="PND";
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local chart = GAMESTATE:GetHardestStepsDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
			if update and msd_exists() then
					self:visible(true);
					self:Load(song:GetSongDir().."msd/"..chart.."/diff.png");
			else
				self:visible(false);
			end;

			local height = self:GetHeight();
			local width = self:GetWidth();
			self:zoomx((frameWidth-offsetX2-10)/width)
			self:zoomy((85)/height)
			
		end;
		BeginCommand=cmd(queuecommand,"Set");
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	};
	
		t[#t+1] = Def.Sprite {
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+32+100;diffusealpha,0.6;zoomy,0;sleep,0.5;decelerate,0.25;zoomy,1;halign,0;valign,0);
		Name="Chord Density";
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
      local chart = GAMESTATE:GetHardestStepsDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
			if update and msd_exists() then
					self:visible(true);
					self:Load(song:GetSongDir().."msd/"..chart.."/cd.png");
			else
				self:visible(false);
			end;
			
			local height = self:GetHeight();
			local width = self:GetWidth();
			self:zoomx((frameWidth-offsetX2-10)/width)
			self:zoomy((85)/height)
			
		end;
		BeginCommand=cmd(queuecommand,"Set");
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	};

	t[#t+1] = Def.Sprite {
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+32+200;diffusealpha,0.6;zoomy,0;sleep,0.5;decelerate,0.25;zoomy,1;halign,0;valign,0);
		Name="Stamina";
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
      local chart = GAMESTATE:GetHardestStepsDifficulty()..GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
			if update and msd_exists() then
					self:visible(true);
					self:Load(song:GetSongDir().."msd/"..chart.."/stam.png");
			else
				self:visible(false);
			end;

			local height = self:GetHeight();
			local width = self:GetWidth();
			self:zoomx((frameWidth-offsetX2-10)/width)
			self:zoomy((85)/height)
			
		end;
		BeginCommand=cmd(queuecommand,"Set");
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	};

	for i=1,#stringList do 
		t[#t+1] = makeText(i)
	end;

else
	t[#t+1] = LoadFont("Common Normal")..{
		InitCommand=cmd(xy,frameX+offsetX2,frameY+offsetY+(1*distY);zoom,fontScale;halign,0;)	;
		BeginCommand=cmd(queuecommand,"Set");
		SetCommand=function(self)
			self:settext("Currently not available for multiplayer")
		end;
	};
end;

return t