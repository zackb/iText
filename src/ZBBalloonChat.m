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
//  ZBBalloonChat.m
//  iText
//
//  Created by Zack Bartel on 3/23/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBBalloonChat.h"
#import "ZBSMSConversation.h"
#import "ZBSMSMessage.h"

static BOOL bubbleImagesLoaded = NO;

@interface ZBBalloonChat (Private)

+ (void) writeImage: (NSString *) name;
+ (void) writeImage: (NSImage *) image named: (NSString *) name;

@end

@implementation ZBBalloonChat

+ (NSString *) urlForConversation: (ZBSMSConversation *)conversation
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent: @"index.html"];
    NSString *html = [HTML_TOP copy];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle: NSDateFormatterMediumStyle];
    [formatter setTimeStyle: NSDateFormatterShortStyle];
    
    [ZBBalloonChat writeImage: [conversation image] named: @"person.png"];
    
	int i;
    for (i = 0; i < [[conversation messages] count]; i++)
    {
		ZBSMSMessage *message = [[conversation messages] objectAtIndex: i];
        html = [html stringByAppendingFormat: HTML_DATE, [formatter stringFromDate: [message date]]];
        if ([message flag] == ZBSMSMessageReceived)
        {
            html = [html stringByAppendingFormat: HTML_CHAT_LEFT, [message text]];
        }
        else if ([message flag] == ZBSMSMessageSent)
        {
            html = [html stringByAppendingFormat: HTML_CHAT_RIGHT, [message text]];
        }
    }

    html = [html stringByAppendingString: HTML_BOTTOM];
    
    [html writeToFile: path atomically: NO encoding: NSUnicodeStringEncoding error: nil];
    
    if (!bubbleImagesLoaded)
    {
        NSImage *me = [[NSImage alloc] initWithData: [[[ABAddressBook sharedAddressBook] me] imageData]];
    
        [ZBBalloonChat writeImage: me named: @"me.png"];
        [me autorelease];
        [ZBBalloonChat writeImage:  @"Texture.jpg"];
        [ZBBalloonChat writeImage: @"BubbleLtGreyL800x1600.png"];
        [ZBBalloonChat writeImage: @"BubbleBlueR800x1600.png"];
        bubbleImagesLoaded = YES;
    }
    
    [formatter autorelease];
    
    return path;
}

@end

@implementation ZBBalloonChat (Private)

+ (void) writeImage: (NSString *) name
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent: name];
    NSImage *image = [NSImage imageNamed: name];
    NSData *data = [image TIFFRepresentation];
    [data writeToFile: path atomically:NO];
}

+ (void) writeImage: (NSImage *) image named: (NSString *) name
{
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent: name];
    [[image TIFFRepresentation] writeToFile: path atomically: NO];
}

@end
