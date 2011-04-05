// +------------------------------------------------------------------------+
// | iText - iPhone SMS Manager                                             |
// +------------------------------------------------------------------------+
// | Copyright (c) 2007 Zack Bartel                                         |
// +------------------------------------------------------------------------+
// | This program is free software; you can redistribute it and/or          |
// | modify it under the terms of the GNU General Public License            | 
// | as published by the Free Software Foundation; either version 2         | 
// | of the License, or (at your option) any later version.                 |
// |                                                                        |
// | This program is distributed in the hope that it will be useful,        |
// | but WITHOUT ANY WARRANTY; without even the implied warranty of         |
// | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          |
// | GNU General Public License for more details.                           |
// |                                                                        |
// | You should have received a copy of the GNU General Public License      |
// | along with this program; if not, write to the Free Software            |
// | Foundation, Inc., 59 Temple Place - Suite 330,                         |
// | Boston, MA  02111-1307, USA.                                           |
// +------------------------------------------------------------------------+
// | Author: Zack Bartel <zack@bartel.com>                                  |
// +------------------------------------------------------------------------+ 
#import "ZBSeparatorCell.h"


@implementation ZBSeparatorCell

- (void) drawWithFrame:(NSRect)frame inView:(NSView *)controlView {
	float lineWidth = frame.size.width * 0.85;
	float lineX = (frame.size.width - lineWidth) / 2;
	float lineY = (frame.size.height - 2) / 2;
	lineY += 0.5;

	[[NSColor colorWithDeviceRed:0.820 green:0.847 blue:0.878 alpha:1.0] set];
	NSRectFill(NSMakeRect(frame.origin.x + lineX, frame.origin.y + lineY, lineWidth, 1));
	
	[[NSColor colorWithDeviceRed:0.976 green:1.0 blue:1.0 alpha:1.0] set];
	NSRectFill(NSMakeRect(frame.origin.x + lineX, frame.origin.y + lineY + 1, lineWidth, 1));
}

- (void) setPlaceholderString:(NSString *)placeholder {
	// do nothing, method is just here in case you bind to a string
	// value, like [NSObject description]
}
@end
