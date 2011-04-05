//
//  ZBNotesController.m
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
//  Created by Zack Bartel on 3/29/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ZBNoteController.h"
#import "ZBNote.h"
#import <sqlite3.h>

@interface ZBNoteController (Private)

- (void) _writeDatabaseFile;

@end

@implementation ZBNoteController

- (id) initWithDatabase: (ZBiPhoneDatabase *) database
{
    self = [super init];
    
    if (self)
    {
        databasePlist = [[database notesDatabasePlist] copy];
        notes = [[NSMutableArray array] retain];
    }
    
    return self;
}

- (int) load
{
    int     err = 0;
    sqlite3 *db = NULL;
    sqlite3_stmt *query = NULL;
    char *sql = "SELECT n.creation_date, b.data, n.title FROM Note n, note_bodies b WHERE n.ROWID = b.note_id";
    
    databaseFile = [NSTemporaryDirectory() stringByAppendingPathComponent: @"notes.db"];
    [self _writeDatabaseFile];

    err = sqlite3_open([databaseFile cStringUsingEncoding: NSASCIIStringEncoding], &db);
    
    if (err)
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return err;
    }

    err = sqlite3_prepare(db, sql, strlen(sql), &query, NULL);
    if (err == SQLITE_OK)
    {
        ZBNote *note = nil;
        while ((err = sqlite3_step(query)) == SQLITE_ROW)
        {
            note = [[ZBNote alloc] init];
            [note setDate: [NSDate dateWithTimeIntervalSince1970: sqlite3_column_int(query, 0)]];
            [note setText: [NSString stringWithCString: (char *)sqlite3_column_text(query, 1) encoding: NSASCIIStringEncoding]];
			[note setSummary: [NSString stringWithCString: (char *)sqlite3_column_text(query, 2) encoding: NSASCIIStringEncoding]];
            [notes addObject: note];
            [note release];
        }
    }

    sqlite3_finalize(query);
    sqlite3_close(db);
    
    return err;
}

- (NSMutableArray *) notes
{
    return notes;
}

- (void) dealloc
{
    if (databasePlist) [databasePlist release];
    if (notes) [notes release];
    
    [super dealloc];
}

@end

@implementation ZBNoteController (Private)

- (void) _writeDatabaseFile
{
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile: databasePlist];
    
    NSData *data = [plist objectForKey: @"Data"];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath: databaseFile])
		[[NSFileManager defaultManager] removeFileAtPath: databaseFile handler:nil];
		
    
    [data writeToFile: databaseFile  atomically: NO];
}

@end

