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
#import "ZBImageTextCell.h"


@implementation ZBImageTextCell
- (id) initTextCell:(NSString *)txt {
	self = [super initTextCell:txt];
	
	if (self) {
		[self setImage:nil];
		textColor = [[NSColor blackColor] retain];
		[self setLineBreakMode:NSLineBreakByTruncatingTail];
	}
	
	return self;
}

- (id) initImageCell:(NSImage *)cellImg {
	self = [self initTextCell:@"Default text"];
	
	if (self) {
		[self setImage:cellImg];
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSImage *) image {
	return image;
}

- (void) setImage:(NSImage *)newImage {
	[newImage retain];
	[image release];
	image = newImage;
}

- (void) setTextColor:(NSColor *)txtColor {
	[txtColor retain];
	[textColor release];
	textColor = txtColor;
}

- (NSColor *) textColor {
	return textColor;
}

#pragma mark -
#pragma mark Drawing

- (NSRect) titleRectForBounds:(NSRect)bounds {
	NSRect imageRect = [self imageRectForBounds:bounds];
	NSSize titleSize = [[self title] sizeWithAttributes:nil];
	NSRect titleRect = bounds;
	
	titleRect.origin.x += 20;
    
	if ([self image] != nil) {
		titleRect.origin.x += imageRect.origin.x + imageRect.size.width;
		titleRect.size.width -= imageRect.size.width + 5;
	}

	titleRect.origin.y = titleRect.origin.y + (bounds.size.height - titleSize.height) / 2;
	titleRect.size.width -= 5; // padding right
	
	return titleRect;
}

- (NSRect) imageRectForBounds:(NSRect)bounds {
	return NSMakeRect(bounds.origin.x + 20, bounds.origin.y + 1, bounds.size.height - 2, bounds.size.height - 2);
}

- (void) drawWithFrame:(NSRect)frame inView:(NSView *)controlView {
	if ([self image] != nil) {
		[[self image] setFlipped:YES];
		[[self image] setSize:[self imageRectForBounds:frame].size];
		[[self image] setScalesWhenResized:YES];

		[[self image] drawInRect:[self imageRectForBounds:frame] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	
	[super drawWithFrame:[self titleRectForBounds:frame] inView:controlView];
}

@end
