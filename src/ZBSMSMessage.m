//
//  ZBSMSMessage.m
//  iText
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
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBSMSMessage.h"


@implementation ZBSMSMessage


- (NSString *) address {
  return address;
}

- (void) setAddress: (NSString *) newValue {
  [address autorelease];
  address = [newValue retain];
}

- (NSString *) text
{
    return text;
}

- (void) setText: (NSString *) newValue
{
    [text autorelease];
    text = [newValue retain];
}


- (NSDate *) date {
  return date;
}

- (void) setDate: (NSDate *) newValue {
  [date autorelease];
  date = [newValue retain];
}


- (ZBSMSMessageFlag) flag {
  return flag;
}

- (void) setFlag: (ZBSMSMessageFlag) newValue {
  flag = newValue;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject: address forKey: @"address"];
    [coder encodeObject: text forKey: @"text"];
    [coder encodeObject: date forKey: @"date"];
    [coder encodeObject: [NSNumber numberWithInt: flag] forKey: @"flag"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    [self setAddress: [coder decodeObjectForKey: @"address"]];
    [self setText: [coder decodeObjectForKey: @"text"]];
    [self setDate: [coder decodeObjectForKey: @"date"]];
    [self setFlag: [[coder decodeObjectForKey: @"flag"] intValue]];
    
    return self;
}

- (void) dealloc
{
    if (address) [address autorelease];
    if (text)    [text autorelease];
    if (date)    [date autorelease];

    [super dealloc];
}

@end
