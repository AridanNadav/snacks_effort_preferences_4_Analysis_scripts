%                                     	Line Style Specifiers	

%                                     	You indicate the line styles, marker types, and colors you want to display using string specifiers, detailed in the following tables:	
%                                     	Specifier	LineStyle
%                                     	'-'	Solid line (default)
%                                     	'--'	Dashed line
%                                     	':'	Dotted line
%                                     	'-.'	Dash-dot line

%                                     	Marker Specifiers	

%                                     	Specifier	Marker Type
%                                     	'+'	Plus sign
%                                     	'o'	Circle
%                                     	'*'	Asterisk
%                                     	'.'	Point
%                                     	'x'	Cross
%                                     	'square' or 's'	Square
%                                     	'diamond' or 'd'	Diamond
%                                     	'^'	Upward-pointing triangle
%                                     	'v'	Downward-pointing triangle
%                                     	'>'	Right-pointing triangle
%                                     	'<'	Left-pointing triangle
%                                     	'pentagram' or 'p'	Five-pointed star (pentagram)
%                                     	'hexagram' or 'h'	Six-pointed star (hexagram)

%                                     	Color Specifiers	
%                                     	Specifier	Color
%                                     	r	Red
%                                     	g	Green
%                                     	b	Blue
%                                     	c	Cyan
%                                     	m	Magenta
%                                     	y	Yellow
%                                     	k	Black
%                                     	w	White

title('XXX')
xlabel('xxx') % x-axis label
ylabel('xxx') % y-axis label
legend('xxx','Location','xxx') % 
ax = gca;
axis([0,40,-0.05,MaxCal])
ax.XTick = [];
ax.YTick = [];
ax.XTickLabel = {'x','x','x','x','x','x'};
ax.YTickLabel = {'x','x','x','x','x','x'};

% 
%                                     	'Location' ? Location with respect to axes'north' | 'south' | 'east' | 'west' | 'northeast' | ...	
%                                     	Location with respect to the axes, specified as one of the location values listed in this table.	
%                                     	Value	Description
%                                     	'north'	Inside top of axes
%                                     	'south'	Inside bottom of axes
%                                     	'east'	Inside right of axes
%                                     	'west'	Inside left of axes
%                                     	'northeast'	Inside top-right of axes (default for 2-D axes)
%                                     	'northwest'	Inside top-left of axes
%                                     	'southeast'	Inside bottom-right of axes
%                                     	'southwest'	Inside bottom-left of axes
%                                     	'northoutside'	Above the axes
%                                     	'southoutside'	Below the axes
%                                     	'eastoutside'	To the right of the axes
%                                     	'westoutside'	To the left of the axes
%                                     	'northeastoutside'	Outside top-right corner of the axes (default for 3-D axes)
%                                     	'northwestoutside'	Outside top-left corner of the axes
%                                     	'southeastoutside'	Outside bottom-right corner of the axes
%                                     	'southwestoutside'	Outside bottom-left corner of the axes
%                                     	'best'	Inside axes where least conflict with data in plot
%                                     	'bestoutside'	To the right of the axes
%                                     	'none'	Determined by Position property


