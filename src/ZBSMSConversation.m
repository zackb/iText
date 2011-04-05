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
//  ZBSMSConversation.m
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBSMSConversation.h"


@implementation ZBSMSConversation

- (id) init
{
    self = [super init];
    
    if (self)
    {
        messages = [[NSMutableArray array] retain];
    }
    
    return self;
}

- (NSMutableArray *) messages 
{
    return messages;
}

- (void) setMessages: (NSMutableArray *) newValue
{
    [messages autorelease];
    messages = [newValue retain];
}

- (ZBSMSMessage *) messageAtIndex: (int) index
{
    if (messages)
    {
        return [messages objectAtIndex: index];
    }
    
    return nil;
}

- (void) addMessage: (ZBSMSMessage *) message
{
    if (message)
    {
        [messages addObject: message];
    }
}

- (ABPerson *) person 
{
    return person;
}

- (void) setPerson: (ABPerson *) newValue {
  [person autorelease];
  person = [newValue retain];
}

- (NSImage *) image {
  return image;
}

- (void) setImage: (NSImage *) newValue {
  [image autorelease];
  image = [newValue retain];
}

- (int) sent {
  return sent;
}

- (void) setSent: (int) newValue {
  sent = newValue;
}

- (int) received {
  return received;
}

- (void) setReceived: (int) newValue {
  received = newValue;
}

- (int) count
{
    int count = 0;
    
    if (messages)
    {
        count = [messages count];
    }
    
    return count;
}

- (NSString *) phoneNumber
{
    NSString *phone = @"";
    
    if ([self person])
    {
        ABMultiValue *phones = [[self person] valueForProperty:kABPhoneProperty];
        phone = [phones valueAtIndex: 0];
    }
    else
    {
        if ([self count] > 0)
        {
            phone = [[[self messages] objectAtIndex: 0] address];
        }
    }
    
    return phone;
}

- (NSComparisonResult)conversationCompare: (ZBSMSConversation *)conversation
{
    NSString *left = [self description];
    NSString *right = [conversation description];

    return [left localizedCaseInsensitiveCompare: right];
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject: messages forKey: @"messages"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    [self setMessages: [coder decodeObjectForKey: @"messages"]];
    return self;
}

- (NSString *) description
{
    NSString *result = nil;
    NSString *first, *last;
    
    if ([self person] == nil)
    {
        if ([self messages])
        {
            result = [[[self messages] objectAtIndex: 0] address];
        }
    }
    else
    {
        first = [person valueForProperty: kABFirstNameProperty];
        last  = [person valueForProperty: kABLastNameProperty];
        if (first != nil && last != nil)
        {
            result = [NSString stringWithFormat: @"%@ %@", first, last];
        }
        else 
        {
            result = [NSString stringWithFormat: @"%@", first == nil ? last : first];
        }
    }
    
    return result;
}

- (void) dealloc
{
    if (messages) [messages autorelease];
    if (person)   [person autorelease];
    if (image)    [image autorelease];
    
    [super dealloc];
}

@end
