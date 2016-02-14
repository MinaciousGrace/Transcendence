t = Def.ActorFrame{}

local frameX = THEME:GetMetric("ScreenTitleMenu","ScrollerX")-10
local frameY = THEME:GetMetric("ScreenTitleMenu","ScrollerY")

t[#t+1] = Def.Quad{
	InitCommand=cmd(draworder,-300;xy,frameX,frameY;zoomto,SCREEN_WIDTH,160;halign,0;diffuse,getMainColor('highlight');diffusealpha,0.5)
}

t[#t+1] = LoadFont("Common Large") .. {
	InitCommand=cmd(xy,5,frameY-80;zoom,0.5;valign,1;halign,0;diffuse,getMainColor('highlight'));
	OnCommand=function(self)
		self:settext(getThemeName().." v"..getThemeVersion());
	end;
}

return t