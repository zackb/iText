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
//  ZBNote.m
//  iText
//
//  Created by Zack Bartel on 3/29/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ZBNote.h"


@implementation ZBNote


- (NSDate *) date {
  return date;
}

- (void) setDate: (NSDate *) newValue {
  [date autorelease];
  date = [newValue retain];
}

- (NSString *) text {
  return text;
}

- (void) setText: (NSString *) newValue {
  [text autorelease];
  text = [newValue retain];
}

- (NSString *) summary {
  return summary;
}

- (void) setSummary: (NSString *) newValue {
  [summary autorelease];
  summary = [newValue retain];
}

- (NSString *) description
{
    return [self summary];
}

- (void) dealloc
{
    if (text) [text autorelease];
    if (date)  [date autorelease];
    
    [super dealloc];
        
}

@end
