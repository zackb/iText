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
//  ZBiPhoneDatabase.h
//  iText
//
//  Created by Zack Bartel on 3/18/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ZBiPhoneDatabase : NSObject {

    NSString *buildVersion;
    NSString *displayName;
    NSString *deviceName;
    NSString *itunesVersion;
    NSDate   *lastBackupDate;
    NSString *phoneNumber;
    NSString *productVersion;
    NSString *serialNumber;
    
    NSString *smsDatabasePlist;
	NSString *smsDatabaseFile;
    NSString *notesDatabasePlist;
}

+ (NSArray *) allDatabases;

- (NSString *) buildVersion;
- (void) setBuildVersion: (NSString *) newValue;

- (NSString *) displayName;
- (void) setDisplayName: (NSString *) newValue;

- (NSString *) deviceName;
- (void) setDeviceName: (NSString *) newValue;

- (NSString *) itunesVersion;
- (void) setItunesVersion: (NSString *) newValue;

- (NSDate *) lastBackupDate;
- (void) setLastBackupDate: (NSDate *) newValue;

- (NSString *) phoneNumber;
- (void) setPhoneNumber: (NSString *) newValue;

- (NSString *) productVersion;
- (void) setProductVersion: (NSString *) newValue;

- (NSString *) serialNumber;
- (void) setSerialNumber: (NSString *) newValue;

- (NSString *) smsDatabasePlist;
- (void) setSMSDatabasePlist: (NSString *) newValue;

- (NSString *) notesDatabasePlist;
- (void) setNotesDatabasePlist: (NSString *) newValue;

- (NSString *) smsDatabaseFile;
- (void) setSmsDatabaseFile: (NSString *) newValue;

@end
