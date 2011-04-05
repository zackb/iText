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
//  ZBiPhoneDatabase.m
//  iText
//
//  Created by Zack Bartel on 3/18/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBiPhoneDatabase.h"

#define DatabasePath @"~/Library/Application Support/MobileSync/Backup"

@interface ZBiPhoneDatabase (Private)

+ (ZBiPhoneDatabase *) databaseFromDirectory: (NSString *) directory;

@end


@implementation ZBiPhoneDatabase

+ (NSArray *) allDatabases
{
	
    NSMutableArray *result = [NSMutableArray array];
    
    NSString *databaseDir = [DatabasePath stringByExpandingTildeInPath];
    
    NSArray *databases = [[NSFileManager defaultManager] directoryContentsAtPath: databaseDir];
    
	int i;
    for (i = 0; i < [databases count]; i++)
    {
		NSString *database = [databases objectAtIndex: i];
        ZBiPhoneDatabase *current = nil;
        current = [self databaseFromDirectory: [databaseDir stringByAppendingPathComponent: database]];
       
       if (current != nil)
       {
            [result addObject: current];
            [current release];
       }
       
    }
    
    return result;
}

#pragma mark -
#pragma mark ACCESSORS

- (NSString *) buildVersion {
  return buildVersion;
}

- (void) setBuildVersion: (NSString *) newValue {
  [buildVersion autorelease];
  buildVersion = [newValue retain];
}


- (NSString *) displayName {
  return displayName;
}

- (void) setDisplayName: (NSString *) newValue {
  [displayName autorelease];
  displayName = [newValue retain];
}


- (NSString *) deviceName {
  return deviceName;
}

- (void) setDeviceName: (NSString *) newValue {
  [deviceName autorelease];
  deviceName = [newValue retain];
}


- (NSString *) itunesVersion {
  return itunesVersion;
}

- (void) setItunesVersion: (NSString *) newValue {
  [itunesVersion autorelease];
  itunesVersion = [newValue retain];
}


- (NSDate *) lastBackupDate {
  return lastBackupDate;
}

- (void) setLastBackupDate: (NSDate *) newValue {
  [lastBackupDate autorelease];
  lastBackupDate = [newValue retain];
}


- (NSString *) phoneNumber {
  return phoneNumber;
}

- (void) setPhoneNumber: (NSString *) newValue {
  [phoneNumber autorelease];
  phoneNumber = [newValue retain];
}


- (NSString *) productVersion {
  return productVersion;
}

- (void) setProductVersion: (NSString *) newValue {
  [productVersion autorelease];
  productVersion = [newValue retain];
}


- (NSString *) serialNumber {
  return serialNumber;
}

- (void) setSerialNumber: (NSString *) newValue {
  [serialNumber autorelease];
  serialNumber = [newValue retain];
}

- (void) setSMSDatabasePlist: (NSString *) newValue {
  [smsDatabasePlist autorelease];
  smsDatabasePlist = [newValue retain];
}

- (NSString *) smsDatabasePlist {
  return smsDatabasePlist;
}

- (NSString *) notesDatabasePlist {
  return notesDatabasePlist;
}

- (void) setNotesDatabasePlist: (NSString *) newValue {
  [notesDatabasePlist autorelease];
  notesDatabasePlist = [newValue retain];
}

- (NSString *) description
{
    return [NSString stringWithFormat: @"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@",
                [self buildVersion],
                [self displayName],
                [self deviceName],
                [self itunesVersion],
                [self lastBackupDate],
                [self phoneNumber],
                [self productVersion],
                [self serialNumber],
                [self smsDatabasePlist]
            ];
}

- (void) dealloc
{
    [super dealloc];
    
    if (buildVersion) [buildVersion release];
    if (displayName) [displayName release];
    if (deviceName) [deviceName release];
    if (itunesVersion) [itunesVersion release];
    if (lastBackupDate) [lastBackupDate release];
    if (phoneNumber) [phoneNumber release];
    if (productVersion) [productVersion release];
    if (serialNumber) [serialNumber release];
    if (smsDatabasePlist) [smsDatabasePlist release];
    if (notesDatabasePlist) [notesDatabasePlist release];
}


- (NSString *) smsDatabaseFile {
  return smsDatabaseFile;
}

- (void) setSmsDatabaseFile: (NSString *) newValue {
  [smsDatabaseFile autorelease];
  smsDatabaseFile = [newValue retain];
}

@end


@implementation ZBiPhoneDatabase (Private)

+ (ZBiPhoneDatabase *) databaseFromDirectory: (NSString *) directory
{
    ZBiPhoneDatabase *db = nil;
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile: [directory stringByAppendingPathComponent: @"Info.plist"]];
    
    if (plist != nil)
    {
        db = [[ZBiPhoneDatabase alloc] init];
        [db setDisplayName:     [plist objectForKey: @"Display Name"]];
        [db setBuildVersion:    [plist objectForKey: @"Build Version"]];
        [db setDeviceName:      [plist objectForKey: @"Device Name"]];
        [db setPhoneNumber:     [plist objectForKey: @"Phone Number"]];
        [db setItunesVersion:   [plist objectForKey: @"iTunes Version"]];
        [db setLastBackupDate:  [plist objectForKey: @"Last Backup Date"]];
        [db setProductVersion:  [plist objectForKey: @"Product Version"]];
        [db setSerialNumber:    [plist objectForKey: @"Serial Number"]];
        
        NSArray *files = [[NSFileManager defaultManager] directoryContentsAtPath: directory];
        int i;
        for (i = 0; i < [files count]; i++)
        {
			NSString *file = [files objectAtIndex: i];
            NSString *currentFile = [directory stringByAppendingPathComponent: file];
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: currentFile];
            
            if ([[dict objectForKey: @"Path"] isEqualToString: @"Library/SMS/sms.db"])
            {
                [db setSMSDatabasePlist: currentFile];

            }
            else if ([[dict objectForKey: @"Path"] isEqualToString: @"Library/Notes/notes.db"])
            {
                [db setNotesDatabasePlist: currentFile];
            }
        }
		if ([db smsDatabasePlist] == nil)
		{
			[db setSmsDatabaseFile: [directory stringByAppendingPathComponent:  @"3d0d7e5fb2ce288813306e4d4636395e047a3d28.mddata"]];
		}
			
    }
    
    return db;
}

@end
