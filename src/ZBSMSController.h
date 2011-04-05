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
//  ZBSMSController.h
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZBiPhoneDatabase.h"
#import "ZBSMSConversation.h"


@interface ZBSMSController : NSObject {
    NSString *databasePlist;
    NSString *databaseFile;
	NSString *smsDatabaseFile;
    NSMutableArray *conversations;
	bool isPre3x;
}

- (id) initWithDatabase: (ZBiPhoneDatabase *) database;
- (int) load;
+ (ABPerson *) personFromAddress: (NSString *) address;
+ (void) setPersonData: (ZBSMSConversation *) conversation;
    
- (NSMutableArray *) conversations;

@end
