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
//  ZBSMSController.m
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import "ZBiPhoneDatabase.h"
#import "ZBSMSController.h"
#import "ZBSMSConversation.h"
#import "ZBSMSMessage.h"
#import <sqlite3.h>


@interface ZBSMSController (Private)

- (void) _writeDatabaseFile;
static void fix_number(char *number);

@end

@implementation ZBSMSController

- (id) initWithDatabase: (ZBiPhoneDatabase *) database
{
    self = [super init];
    
    if (self)
    {
		// HACK for new firmware
		if ([database smsDatabasePlist] == nil)
		{
			smsDatabaseFile = [[database smsDatabaseFile] copy];
			isPre3x = NO;
		}
		else
		{
			databasePlist = [[database smsDatabasePlist] copy];
			isPre3x = YES;
		}
		
        conversations = [NSMutableArray array]; //TODO: Should alloc this and release it in dealloc: Bug can be seen in ZBController after load'ing and not releasing
    }
    
    return self;
}

- (int) load
{
    int     err = 0;
    sqlite3 *db = NULL;
    char    **result = NULL;
    int     nrow = 0;
    int     ncolumn = 0;
    
    databaseFile = [NSTemporaryDirectory() stringByAppendingPathComponent: @"sms.db"];
	
	[self _writeDatabaseFile];
    
    err = sqlite3_open([databaseFile cStringUsingEncoding: NSASCIIStringEncoding], &db);
    
    if (err)
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
        return err;
    }
    
    err = sqlite3_get_table(db, "SELECT ltrim(replace(replace(replace(replace(replace(address, '(', ''), ')', ''), ' ', ''), '-', ''), '+', ''), '1') as address, text, date, flags from message order by ltrim(replace(replace(replace(replace(replace(address, '(', ''), ')', ''), ' ', ''), '-', ''), '+', ''), '1'), date",
                                &result, &nrow, &ncolumn, NULL);
    //TODO sqlite3_free_table()
	if (nrow < 1)
	{
		err = sqlite3_close(db);
		return err;
	}
	//TODO: Check err
    int i;
    int sent = 0, received = 0;
    char address[50] = { '\0' };
    ZBSMSConversation *conversation = nil;
    ZBSMSMessage *message = nil;
    
	if (!isPre3x)
	{
		int i;
		for (i = 0; i < 2000; i += 4)
		{
			char *p = result[i + 1];
			printf("%s\n", p);
		}
		//return 0;
	}
	
	i = 8;
	while (result[i] == NULL) i += 4;
	
    strncpy(address, result[i], 50);
    for (; i < (nrow * 4) + 4; i += 4)
    {
        if (conversation == nil)
        {
            conversation = [[ZBSMSConversation alloc] init];
        }
        
        
		if (result[i] != NULL && result[i + 1] != NULL)
		{
			message = [[ZBSMSMessage alloc] init];

			[message setAddress: [NSString stringWithCString: result[i]     encoding: NSASCIIStringEncoding]];
			[message setText:    [NSString stringWithCString: result[i + 1] encoding: NSASCIIStringEncoding]];
			[message setDate:    [NSDate dateWithTimeIntervalSince1970: atoi(result[i + 2])]];
			[message setFlag:    atoi(result[i + 3])];
			
			[conversation addMessage: message];
			
			if ([message flag] == ZBSMSMessageReceived)
			{
				received++;
			}
			else if ([message flag] == ZBSMSMessageSent)
			{
				sent++;
			}
			
			[message release];
		}
            
        if (i < (nrow * 4))
        {
            if (strcmp(address, result[i + 4]))
            {
                [ZBSMSController setPersonData: conversation];
                [conversation setSent: sent];
                [conversation setReceived: received];
                strncpy(address, result[i + 4], 50);
                [[self conversations] addObject: conversation];
                [conversation release];
                conversation = nil;
                sent = received = 0;
            }
        }
        else
        {
            [ZBSMSController setPersonData: conversation];
            [conversation setSent: sent];
            [conversation setReceived: received];
            [[self conversations] addObject: conversation];
            [conversation release];
            conversation = nil;
            sent = received = 0;
        }
    }

    sqlite3_close(db);
    
    return err;
}

+ (ABPerson *) personFromAddress: (NSString *) address
{
    ABPerson *result = nil;
    char phone1[30], phone2[30];
    NSArray *people = [[ABAddressBook sharedAddressBook] people];

    memset(phone1, '\0', 30);
    strncpy(phone1, [address cStringUsingEncoding: NSASCIIStringEncoding], 30);
    
    fix_number(phone1);

	int i;
    for (i = 0; i < [people count]; i++)
    {
		ABPerson *person = [people objectAtIndex: i];
        memset(phone2, '\0', 30);
        ABMultiValue *phones = [person valueForProperty:kABPhoneProperty];
        NSString *phone = nil;

        if ([phones count] > 0)
        {
            int i;
            for (i = 0;  i < [phones count]; i++)
            {
                phone = [phones valueAtIndex: i];
                strncpy(phone2, [phone cStringUsingEncoding: NSASCIIStringEncoding], 30);
                fix_number(phone2);

                if (!strcmp(phone1, phone2))
                {
                    result = person;
                    return result;
                }
            }
        }
    }
    
    return result;
}

+ (void) setPersonData: (ZBSMSConversation *) conversation
{

    ZBSMSMessage *message = nil;
    
    if (conversation && [conversation messages])
    {
        message = [conversation messageAtIndex: 0];
        
        [conversation setPerson: [self personFromAddress: [message address]]];
        if ([[conversation person] imageData])
            [conversation setImage: [[NSImage alloc] initWithData: [[conversation person] imageData]]];
        else
            [conversation setImage: [NSImage imageNamed: @"NSUser"]];
    }
}

- (NSMutableArray *) conversations 
{
    return conversations;
}

- (void) dealloc
{
    if (databaseFile)  [databaseFile  autorelease];
    if (databasePlist) [databasePlist autorelease];
    if (conversations) [conversations autorelease];

    [super dealloc];
}

@end

@implementation ZBSMSController (Private)

- (void) _writeDatabaseFile
{
	
	NSData *data;
	
	if (databasePlist != nil)
	{
		NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile: databasePlist];
    
		data = [plist objectForKey: @"Data"];
    }
	else if (smsDatabaseFile != nil)
	{
			// HACK for new firmware
		data = [[NSData alloc] initWithContentsOfFile: smsDatabaseFile];
	}
	
	if ([[NSFileManager defaultManager] fileExistsAtPath: databaseFile])
		[[NSFileManager defaultManager] removeFileAtPath: databaseFile handler:nil];
	
	
    [data writeToFile: databaseFile  atomically: NO];
}

static void fix_number(char *number)
{
    int i, j;
    int index = 0;
    int length = strlen(number);

    char junk[30];
    memset(junk, 'x', 30);

    for (i = 0; i < length; i++)
    {
        if (isnumber(number[i]))
        {
            number[index++] = number[i];
        }
    }

    while (index < length)
        number[index++] = '\0';

    length = strlen(number);

    if (length > 6)
    {
        for (i = length, j = 7; i >  length - 8, j >= 0; i--, j--)
        {
            junk[j] = number[i];
        }
    }
    else
        strcpy(junk, number);

    strcpy(number, junk);
}


@end
