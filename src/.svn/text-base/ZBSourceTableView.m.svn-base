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

#import "ZBSourceTableView.h"

@implementation ZBSourceTableView
- (id) initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {	
		
	}
	
	return self;
}

- (void) awakeFromNib {
	//[self setBackgroundColor:[NSColor colorWithDeviceRed:0.906 green:0.930 blue:0.965 alpha:1.0]];
	//[self setBackgroundColor: [NSColor colorWithCalibratedRed:83.0 / 256.0 green:103.0 / 256.0 blue:139.0 / 256.0 alpha:1.0]];
    [self setIntercellSpacing:NSMakeSize(0.0, 0.1)];
	heightCache = [[NSMutableDictionary alloc] init];
}

- (float) heightForRow:(int)row {
	if ([[self delegate] respondsToSelector:@selector(heightFor:row:)]) {
		return [[self delegate] heightFor:self row:row];
	}
	
	return [self rowHeight];
}

- (Class) cellClassForRow:(int) row {
	switch (row) {
		case 0:
		case 1:
		default:
			return [[[self tableColumns] objectAtIndex:0] dataCell];
			break;
	}
}

- (NSRect) rectOfRow:(int)row {	
	NSNumber *cachedY = [heightCache objectForKey:[NSNumber numberWithInt:row]];
	float y = 0;
	
	if (cachedY == nil) {
		if (row > 0) {
			NSRect previousRect = [self rectOfRow:row - 1];
			y = previousRect.origin.y + previousRect.size.height;
			y += 1;
		} else {
			y = 0;
		}
		
		[heightCache setObject:[NSNumber numberWithFloat:y] forKey:[NSNumber numberWithInt:row]];
	} else {
		y = [cachedY floatValue];
	}
	
	NSRect rowRect = [super rectOfRow:row];
	rowRect.origin.y = y;
	rowRect.size.height = [self heightForRow:row];
	
	return rowRect;
}

- (NSRect) frameOfCellAtColumn:(int)col row:(int)row {
	NSRect cellRect = [super frameOfCellAtColumn:col row:row];
	NSRect rowRect = [self rectOfRow:row];
	
	cellRect.origin.y = rowRect.origin.y;
	cellRect.size.height = rowRect.size.height -1;
		
	return cellRect;
}

- (int) rowAtPoint:(NSPoint)p {
	int row = -1;
	int i;
	
	for (i=0; i<[self numberOfRows]; i++) {
		if (NSPointInRect(p, [self rectOfRow:i])) { row = i; break; }
	}
	
	return row;
}

- (void) reloadData {
	[heightCache removeAllObjects];
	
	[super reloadData];
}
@end
