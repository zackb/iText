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
//
//  ZBHeaderTextCell.m
//  iText
//
//  Created by Zack Bartel on 3/22/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBHeaderTextCell.h"


@implementation ZBHeaderTextCell

- (id) initTextCell:(NSString *)txt {
	self = [super initTextCell:txt];
	
	if (self) {
		//textColor = [[NSColor blackColor] retain];
		[self setLineBreakMode:NSLineBreakByTruncatingTail];
        [self setHeight: 30.0];
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (float) height {
  return height;
}

- (void) setHeight: (float) newValue {
  height = newValue;
}

#pragma mark -
#pragma mark Drawing

- (NSRect) titleRectForBounds:(NSRect)bounds {
	NSRect imageRect = [self imageRectForBounds:bounds];
	NSSize titleSize = [[self title] sizeWithAttributes:nil];
	NSRect titleRect = bounds;
	
	titleRect.origin.x += 5;
	if ([self image] != nil) {
		titleRect.origin.x += imageRect.origin.x + imageRect.size.width;
		titleRect.size.width -= imageRect.size.width + 5;
	}
	titleRect.origin.y = titleRect.origin.y + (bounds.size.height - titleSize.height) / 2;
	titleRect.size.width -= 5; // padding right
	
	return titleRect;
}

- (NSRect) rectForBounds:(NSRect)bounds {
	return NSMakeRect(bounds.origin.x + 20, bounds.origin.y + 1, bounds.size.height - 2, bounds.size.height - 2);
}

- (void) drawWithFrame:(NSRect)frame inView:(NSView *)controlView {

    NSFontManager* fontManager = [NSFontManager sharedFontManager];
    NSString* title = [[self stringValue] uppercaseString];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithDictionary:[[self attributedStringValue] attributesAtIndex:0 effectiveRange:NULL]];
    NSFont* font = [attrs objectForKey:NSFontAttributeName];

    [attrs setValue:[fontManager convertFont:font toHaveTrait:NSBoldFontMask] forKey:NSFontAttributeName];
    [attrs setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];

    [attrs setValue:[NSColor darkGrayColor] forKey:NSForegroundColorAttributeName];
    [title drawInRect:[self titleRectForBounds: frame] withAttributes:attrs];
    
}

@end
