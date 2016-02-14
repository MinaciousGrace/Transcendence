local update = false

local msd90
local msd91
local msd92
local msd93
local msd94
local msd95
local msd96
local msd97
local song
local widthmult = 2.535
local yinc = 24
local fontzoom = 0.45
local fontyoff = 3
local fontxoff = 5
local barheight = 18
local barspace = 5

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

t[#t+1] = Def.ActorFrame{
	Name="MsdData";
	InitCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update and msd_exists() then
			msd90 = split(GetMsdData(90),"%,")
			msd91 = split(GetMsdData(91),"%,")
			msd92 = split(GetMsdData(92),"%,")
			msd93 = split(GetMsdData(93),"%,")
			msd94 = split(GetMsdData(94),"%,")
			msd95 = split(GetMsdData(95),"%,")
			msd96 = split(GetMsdData(96),"%,")
			msd97 = split(GetMsdData(97),"%,")
		end;
	end;
	Def.Quad{
		Name = "DiffMouseOver";
		InitCommand=cmd(xy,20,264;zoomto,90,30;halign,0;valign,0;diffusealpha,0);
	};
	
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
}

t[#t+1] = LoadFont("Common Large") .. {
	Name="Doot";
	InitCommand=cmd(xy,19,SCREEN_BOTTOM-225;visible,true;halign,0;zoom,0.4;maxwidth,capWideScale(get43size(360),360)/capWideScale(get43size(0.45),0.45));
	BeginCommand=cmd(queuecommand,"Set");
	CodeMessageCommand=function(self,params)
		local rate = getrate()
		if params.Name == "PrevScore" and tonumber(rate) < 2 and getTabIndex() == 0 then
			ratezz = GAMESTATE:GetSongOptionsObject(2):MusicRate(rate+0.1)
			ratezzz = GAMESTATE:GetSongOptionsObject(0):MusicRate(rate+0.1)
			MESSAGEMAN:Broadcast("CurrentSongChanged")
		elseif params.Name == "NextScore" and tonumber(rate) > 0.8 and getTabIndex() == 0 then
			ratezz = GAMESTATE:GetSongOptionsObject(2):MusicRate(rate-0.1)
			ratezz = GAMESTATE:GetSongOptionsObject(0):MusicRate(rate-0.1)
			MESSAGEMAN:Broadcast("CurrentSongChanged")
		end
	end;
	SetCommand=function(self)
		if update then
			local rate = GAMESTATE:GetSongOptions('ModsLevel_Song')
			if rate == "" then
				rate = "1.0xMusic"
			end
			self:settext(rate)
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = LoadFont("Common Normal") .. {
	Name="Calc Version";
	InitCommand=cmd(xy,116,SCREEN_BOTTOM-224;visible,true;halign,0;zoom,0.35;valign,0;maxwidth,capWideScale(get43size(360),360)/capWideScale(get43size(0.45),0.45));
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update and msd_exists(_) then
			self:settext("Msd Vers: "..GetMsdData("V"))
		else
			self:settext("")
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = LoadFont("Common Normal") .. {
	Name="Override";
	InitCommand=cmd(xy,196,SCREEN_BOTTOM-224;visible,true;halign,0;zoom,0.35;valign,0;maxwidth,capWideScale(get43size(360),360)/capWideScale(get43size(0.45),0.45));
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update and msd_exists(_) and themeConfig:get_data().global.ShowOverrideMargins then
			local ovr = GetMsdData("ovr")
			if tonumber(ovr)==0 then
				self:settext("")
			else
				self:settext("Override: "..ovr.."%")
			end
		else
			self:settext("")
		end
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};

t[#t+1] = LoadFont("Common Large") .. {
	Name="Msd";
	InitCommand=cmd(xy,(capWideScale(get43size(384),384)-258),SCREEN_BOTTOM-204;visible,true;halign,0;zoom,0.55;maxwidth,capWideScale(get43size(360),360)/capWideScale(get43size(0.45),0.45));
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			local song = GAMESTATE:GetCurrentSong()
			if song ~= nil then
			if GetMsdData(93) ~= nil then
				diff = msd93[2]
			else
				local stepsP1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
				local enabled = GAMESTATE:IsPlayerEnabled(PLAYER_1);
				if enabled and stepsP1 ~= nil then
					diff = stepsP1:GetMeter();
				end
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
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
};


t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(xy,116,246;zoom,0.92;halign,0;valign,0);
	Name="MsdDataDisplay";
	BeginCommand=function(self)
		if GAMESTATE:IsHumanPlayer(PLAYER_1) then
			self:visible(true)
		else
			self:visible(false)
		end;
	end;
	PlayerJoinedMessageCommand=function(self, params)
		if params.Player == PLAYER_1 then
			self:visible(true);
		end;
	end;
	PlayerUnjoinedMessageCommand=function(self, params)
		if params.Player == PLAYER_1 then
			self:visible(false);
		end;
	end;
	SetCommand=function(self)
		song = GAMESTATE:GetCurrentSong()
		if song ~= nil and msd_exists() then
			self:diffusealpha(1)
		else
			self:diffusealpha(0)
		end;
	end;
	
	Def.Quad{
		InitCommand=cmd(xy,-5,yinc-5;zoomto,100*widthmult+10,yinc*4+4;halign,0;valign,0;diffusealpha,0.5;diffuse,color("#333333CC"));
	};
	
	-- Speed meter
	Def.Quad{
	InitCommand=cmd(xy,0,yinc;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Easy');diffusealpha,0.4);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(100*widthmult,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Easy');diffusealpha,0.5);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(msd93[3]*widthmult*100,barheight)
			end
		end;
	end;
	};
		Def.Quad{
	InitCommand=cmd(xy,0,yinc;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Easy');diffusealpha,1);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(6,barheight)
				self:x(msd93[3]*widthmult*100-6)
				self:diffusealpha(msd93[3]*10)
			end
		end;
	end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,fontxoff,yinc+fontyoff;halign,0;valign,0;zoom,fontzoom;);
		SetCommand=function(self)
			self:settext("Speed")
		end;
	};
	
	-- Stamina meter
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*2;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Hard');diffusealpha,0.4);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(100*widthmult,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*2;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Hard');diffusealpha,0.5);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(msd93[4]*widthmult*100,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*2;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Hard');diffusealpha,1);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(6,barheight)
				self:x(msd93[4]*widthmult*100-6)
				self:diffusealpha(msd93[4]*10)
			end
		end;
	end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,fontxoff,yinc*2+fontyoff;halign,0;valign,0;zoom,fontzoom;);
		SetCommand=function(self)
			self:settext("Stamina")
		end;
	};
	
	-- Technical meter
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*3;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Challenge');diffusealpha,0.4);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(100*widthmult,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*3;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Challenge');diffusealpha,0.5);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(msd93[5]*widthmult*100,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*3;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Challenge');diffusealpha,1);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(6,barheight)
				self:x(msd93[5]*widthmult*100-6)
				self:diffusealpha(msd93[5]*10)
			end
		end;
	end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,fontxoff,yinc*3+fontyoff;halign,0;valign,0;zoom,fontzoom;);
		SetCommand=function(self)
			self:settext("Technical")
		end;
	};
	
	-- Jack meter
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*4;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Medium');diffusealpha,0.4);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(100*widthmult,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*4;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Medium');diffusealpha,0.5);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(msd93[6]*widthmult*100,barheight)
			end
		end;
	end;
	};
	Def.Quad{
	InitCommand=cmd(xy,0,yinc*4;zoomto,0,0;halign,0;valign,0;diffuse,getVividDifficultyColor('Difficulty_Medium');diffusealpha,1);
	BeginCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if update then
			if msd_exists() then
				self:zoomto(6,barheight)
				self:x(msd93[6]*widthmult*100-6)
				self:diffusealpha(msd93[6]*10)
			end
		end;
	end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,fontxoff,yinc*4+fontyoff;halign,0;valign,0;zoom,fontzoom;);
		SetCommand=function(self)
			self:settext("Jack")
		end;
	};
	
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
}

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(xy,50,162;zoom,0.45;halign,0;valign,0;diffusealpha,0.9;);
	Name="MsdExtended";
	
	Def.Quad{
		InitCommand=cmd(xy,-72,10;zoomto,144,215;halign,0;valign,0;diffuse,color("#333333CC");diffusealpha,0.9);
	};
	Def.Quad{
		InitCommand=cmd(xy,-72,122;zoomto,144,32;halign,0;valign,1;diffuse,getMainColor('highlight');diffusealpha,0.66);
	};
	
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,26;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("90%: "..msd90[2])
			end
		end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,52;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("91%: "..msd91[2])
			end
		end;
	};
	LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,78;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("92%: "..msd92[2])
			end
		end;
	};
		LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,104;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("93%: "..msd93[2])
			end
		end;
	};
		LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,130;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("94%: "..msd94[2])
			end
		end;
	};
		LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,156;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("95%: "..msd95[2])
			end
		end;
	};
		LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,182;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("96%: "..msd96[2])
			end
		end;
	};
		LoadFont("Common Normal")..{
		InitCommand=cmd(xy,0,208;);
		SetCommand=function(self)
			if update and msd_exists() then
			self:settext("97%: "..msd97[2])
			end
		end;
	};
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
}

local function Update(self)
	t.InitCommand=cmd(SetUpdateFunction,Update);
	if update then
		if (isOver(self:GetChildren().MsdData:GetChildren().DiffMouseOver) and msd_exists()) then
			self:GetChild("MsdExtended"):visible(true)
	    else
	    	self:GetChild("MsdExtended"):visible(false)
	    end;
    else
    	self:GetChild("MsdExtended"):visible(false)
    end;
end; 

t.InitCommand=cmd(SetUpdateFunction,Update);

return t