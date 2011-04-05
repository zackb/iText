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
//  ZBController.h
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "ZBiPhoneDatabase.h"
#import "ZBSourceTableView.h"
#import "ZBSMSConversation.h"

#define kAppleScriptAddressBookOpenPerson @"tell application \"Address Book\"\nactivate\nset selection to first person whose name is \"%@\"\nend tell"

@interface ZBController : NSObject 
{

    IBOutlet NSPopUpButton *databasesMenu;
    IBOutlet ZBSourceTableView *sourceList;
    IBOutlet NSView *personView;
    IBOutlet WebView *webView;
    IBOutlet NSProgressIndicator *progressIndicator;
    IBOutlet NSTextField *databaseMessageCountLabel;
    IBOutlet NSTextField *personName;
    IBOutlet NSTextField *personPhoneNumber;
    IBOutlet NSTextField *personMessageCount;
    IBOutlet NSTextField *personSentReceived;
    IBOutlet NSButton *personButton;
    
    NSCell *headerCell;
	NSCell *defaultCell;
    
    NSArray *databases;
    NSArray *conversations;
    NSArray *notes;
    
    ZBiPhoneDatabase *selectedDatabase;
    ZBSMSConversation *selectedConversation;
    
    int databaseMessageCount;
}

- (void) selectDatabase: (ZBiPhoneDatabase *) database;
- (void) selectConversation: (ZBSMSConversation *) conversation;
- (BOOL) openFromFile: (NSString *) filename;
- (void) personViewAnimateIn;
- (void) personViewAnimateOut;

- (IBAction) databaseMenuClicked: (id) sender;
- (IBAction) sourceListClicked: (id) sender;
- (IBAction) save: (id) sender;
- (IBAction) open: (id) sender;
- (IBAction) personButtonClicked: (id) sender;
- (IBAction) print: (id) sender;

@end
