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
//  ZBSMSConversation.h
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AddressBook/AddressBook.h>

#import "ZBSMSMessage.h"


@interface ZBSMSConversation : NSObject <NSCoding>
{
    NSMutableArray *messages;
    ABPerson *person;
    NSImage *image;
    int sent;
    int received;
}

- (NSMutableArray *) messages;
- (ZBSMSMessage *) messageAtIndex: (int) index;
- (void) addMessage: (ZBSMSMessage *) message;
- (int) count;

- (ABPerson *) person;
- (void) setPerson: (ABPerson *) newValue;

- (NSImage *) image;
- (void) setImage: (NSImage *) newValue;

- (int) sent;
- (void) setSent: (int) newValue;

- (int) received;
- (void) setReceived: (int) newValue;

- (NSString *) phoneNumber;

- (NSComparisonResult)conversationCompare: (ZBSMSConversation *)conversation;


@end
