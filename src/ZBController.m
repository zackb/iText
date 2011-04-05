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
//  ZBController.m
//  iText
//
//  Created by Zack Bartel on 3/19/08.
//  Copyright 2008 Zack Bartel. All rights reserved.
//

#import <WebKit/WebKit.h>

#import "ZBController.h"
#import "ZBiPhoneDatabase.h"
#import "ZBSMSController.h"
#import "ZBSMSConversation.h"
#import "ZBNoteController.h"
#import "ZBNoteCanvas.h"
#import "ZBNote.h"

#import "ZBSeparatorCell.h"
#import "ZBImageTextCell.h"
#import "ZBHeaderTextCell.h"

#import "ZBBalloonChat.h"

@implementation ZBController

- (void) awakeFromNib
{
    databaseMessageCount = 0;
    
	headerCell = [[ZBHeaderTextCell alloc] initTextCell: @"Messages"];
	defaultCell = [[ZBImageTextCell alloc] initTextCell:@"Default title"];
    
    databases = [[ZBiPhoneDatabase allDatabases] retain];
    
    if (databases && [databases count] > 0)
    {
		int i;
        for (i = 0; i < [databases count]; i++)
        {
			ZBiPhoneDatabase *database = [databases objectAtIndex: i];
			NSString *title = [NSString stringWithFormat: @"%@ (%@)", [database displayName], [database serialNumber]];
            [databasesMenu addItemWithTitle: title];
        }
        
        [self selectDatabase: [databases objectAtIndex: 0]];
    }
    else
    {
        [databasesMenu addItemWithTitle: @"No iPhone's Available"];
    }
}

#pragma mark -
#pragma mark UTILITY METHODS

- (void) selectDatabase: (ZBiPhoneDatabase *) database
{
    if (selectedDatabase)
    {
        [selectedDatabase autorelease];
        selectedDatabase = nil;
    }
    
    selectedDatabase = [database retain];
    
    ZBSMSController *controller = [[ZBSMSController alloc] initWithDatabase: selectedDatabase];
    [controller load];
    
    if (conversations)
    {
        [conversations release];
        conversations = nil;
    }  
     
    conversations = [[[controller conversations] sortedArrayUsingSelector: @selector(conversationCompare:)] retain];
    
    if (conversations)
    {
        databaseMessageCount = 0;
		int i;
        for (i = 0; i < [conversations count]; i++)
        {
			ZBSMSConversation *conversation = [conversations objectAtIndex: i];
            databaseMessageCount += [conversation count];
        }
        [databaseMessageCountLabel setStringValue: [NSString stringWithFormat: @"%d messages", databaseMessageCount]];
    }
        
    ZBNoteController *noteController = [[ZBNoteController alloc] initWithDatabase: selectedDatabase];
    [noteController load];
    
    if (notes)
    {
        [notes release];
        notes = nil;
    }
    
    notes = [[noteController notes] retain];
    
    //[controller release];
    [noteController release];
    
    [sourceList reloadData];
}

- (void) selectConversation: (ZBSMSConversation *) conversation
{
    BOOL animateIn = NO;

    if (!selectedConversation)
    {
        animateIn = YES;
    }
    
    if (conversation != selectedConversation)
    {
        selectedConversation = conversation;
        [personButton setImage: [conversation image]];
        [personName setStringValue: [selectedConversation description]];
        [personPhoneNumber setStringValue: [selectedConversation phoneNumber]];
        [personMessageCount setStringValue: 
                            [NSString stringWithFormat: @"%d messages", [selectedConversation count]]];
        [personSentReceived setStringValue:
                            [NSString stringWithFormat: @"%d sent %d received", [selectedConversation sent], [selectedConversation received]]];

        if (animateIn)
        {
            [self personViewAnimateIn];
        }
        
        [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [ZBBalloonChat urlForConversation: selectedConversation]]]];
    }
}

- (void) selectNote: (ZBNote *) note
{
    if (selectedConversation)
    {
        [self personViewAnimateOut];
    }
    
    selectedConversation = nil;
    
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: [ZBNoteCanvas urlForNote: note]]]];

}

- (BOOL) openFromFile: (NSString *) filename
{
    if (conversations)
    {
        [conversations autorelease];
        conversations = nil;
    }
    
    NSDictionary *root = [NSKeyedUnarchiver unarchiveObjectWithFile: filename];
    
    conversations = [[NSMutableArray alloc] initWithArray: [root valueForKey: @"conversations"]];
    
    if (conversations)
    {
		int i;
        for (i = 0; i < [conversations count]; i++)
        {
			ZBSMSConversation *conversation = [conversations objectAtIndex: i];
            [ZBSMSController setPersonData: conversation];
        }
    }
    
    databaseMessageCount = 0;
	int i;
    for (i = 0; i < [conversations count]; i++)
    {
		ZBSMSConversation *conversation = [conversations objectAtIndex: i];
        databaseMessageCount += [conversation count];
    }
    [databaseMessageCountLabel setStringValue: [NSString stringWithFormat: @"%d messages", databaseMessageCount]];
    
    //We Don't save notes data
    if (notes)
    {
        [notes autorelease];
        notes = nil;
    }
    
    [sourceList reloadData];
    
    //TODO: Error check
    return YES;
}

- (void) personViewAnimateIn
{
    NSViewAnimation *animation;
    NSMutableDictionary *secondViewDict;
    NSMutableDictionary *firstViewDict;
    
    NSView *firstView = personView;
    NSView *secondView = [[sourceList superview] superview];

    float personViewHeight = 200.0f;
    firstViewDict = [NSMutableDictionary dictionaryWithCapacity:3];

    [firstViewDict setObject:firstView forKey:NSViewAnimationTargetKey];

    NSRect viewZeroSize = [firstView frame];
    viewZeroSize.size.height = personViewHeight - 20;
    [firstViewDict setObject:[NSValue valueWithRect:viewZeroSize]
             forKey:NSViewAnimationEndFrameKey];

    secondViewDict = [NSMutableDictionary dictionaryWithCapacity:3];

    [secondViewDict setObject:secondView forKey:NSViewAnimationTargetKey];

    viewZeroSize = [secondView frame];
    viewZeroSize.origin.y = personViewHeight;
    viewZeroSize.size.height = [[secondView superview] frame].size.height - personViewHeight;
    [secondViewDict setObject:[NSValue valueWithRect:viewZeroSize]
             forKey:NSViewAnimationEndFrameKey];

    animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray
                arrayWithObjects:firstViewDict, secondViewDict, nil]];
 
    [animation setDuration:1.0];
    [animation setAnimationCurve:NSAnimationEaseIn];
 
    [animation startAnimation];
 
    [animation release];

}

- (void) personViewAnimateOut
{
    NSViewAnimation *animation;
    NSMutableDictionary *secondViewDict;
    NSMutableDictionary *firstViewDict;
    
    NSView *firstView = personView;
    NSView *secondView = [[sourceList superview] superview];

    firstViewDict = [NSMutableDictionary dictionaryWithCapacity:3];

    [firstViewDict setObject:firstView forKey:NSViewAnimationTargetKey];

    NSRect viewZeroSize = [firstView frame];
    viewZeroSize.size.height = 0.001;
    
    [firstViewDict setObject:[NSValue valueWithRect:viewZeroSize]
             forKey:NSViewAnimationEndFrameKey];

    secondViewDict = [NSMutableDictionary dictionaryWithCapacity:3];

    [secondViewDict setObject:secondView forKey:NSViewAnimationTargetKey];

    viewZeroSize = [secondView frame];
    viewZeroSize.origin.y = [webView frame].origin.y;
    viewZeroSize.size.height = [webView frame].size.height;

    [secondViewDict setObject:[NSValue valueWithRect:viewZeroSize]
             forKey:NSViewAnimationEndFrameKey];

    animation = [[NSViewAnimation alloc] initWithViewAnimations:[NSArray
                arrayWithObjects:firstViewDict, secondViewDict, nil]];
 
    [animation setDuration: 0.5];
    [animation setAnimationCurve:NSAnimationEaseIn];
 
    [animation startAnimation];
 
    [animation release];

}

#pragma mark -
#pragma mark SOURCELIST DATASOURCE METHODS

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    int count = 0;
    
    if (notes)
        count = [conversations count] + [notes count] + 2;
    else 
        count = [conversations count] + 1;
        
    return count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(int)row
{
    if (row == 0)
    {
        return @"Messages";
    }
    else if (conversations && [conversations count] > row - 1)
    {
            return [[conversations objectAtIndex: row - 1] description];
    }
    else if (row == [conversations count] + 1)
    {
        return @"Notes";
    }
    else
    {
        return [[notes objectAtIndex: row - [conversations count] - 2] description];
    }
    
    return @"Error!";
}

- (float) heightFor:(NSTableView *)tableView row:(int)row {

    if (row == 0)
    {
        return [(ZBHeaderTextCell *)headerCell height];
    }
    
	return [tableView rowHeight];
}

- (BOOL) tableView:(NSTableView *)tableView shouldSelectRow:(int)row {
	return row != 0 && row != [conversations count] + 1;
}

#pragma mark -
#pragma mark SOURCELIST DELEGATE METHODS

- (id) tableColumn:(NSTableColumn *)column inTableView:(NSTableView *)tableView dataCellForRow:(int)row {
	NSCell *cell = nil;
    
    if (row == 0 || row == [conversations count] + 1) {
        cell = headerCell;
	} else {
        //[defaultCell setImage: [[conversations objectAtIndex: row - 1] image]];
        cell = defaultCell;
	}
	
	return cell;
}

#pragma mark -
#pragma mark IBACTION METHODS

- (IBAction) databaseMenuClicked: (id) sender
{
    int selected = [databasesMenu indexOfSelectedItem];
    
    [self selectDatabase: [databases objectAtIndex: selected]];
}

- (IBAction) sourceListClicked: (id) sender
{
    int selectedRow = [sender selectedRow] - 1;
    
    if (selectedRow >= 0 && selectedRow < [conversations count])
    {
        ZBSMSConversation *conversation = [conversations objectAtIndex: selectedRow];
        [self selectConversation: conversation];
    }
    else if (notes && [notes count] > selectedRow - [conversations count] - 1)
    {
        [self selectNote: [notes objectAtIndex: selectedRow - [conversations count] - 1]];
    }
}

- (IBAction) save: (id) sender
{
    int flag;
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel retain];
    [panel setRequiredFileType:@"itext"];
    flag = [panel runModal];
    if(flag == NSOKButton)	
    {
        NSMutableDictionary *root = [NSMutableDictionary dictionary];
    
        [root setValue: conversations forKey: @"conversations"];
    
        [NSKeyedArchiver archiveRootObject: root toFile: [panel filename]];
    }
    
    [panel release];
    
}

- (IBAction) open: (id) sender
{
    int flag;
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel retain];
    flag = [panel runModalForTypes: [NSArray arrayWithObject: @"itext"]];
    if(flag == NSOKButton)
    {
        [self openFromFile: [panel filename]];
    }
    
    [panel release];
}

- (IBAction) print: (id) sender
{
    [webView print: self];
}

- (IBAction) personButtonClicked: (id) sender
{
    if (selectedConversation)
    {
        NSAppleScript *script = [[ NSAppleScript alloc ] initWithSource: 
                [NSString stringWithFormat: kAppleScriptAddressBookOpenPerson, [selectedConversation description]]];
        
        [script executeAndReturnError: nil];
    }
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
    return [self openFromFile: filename];
}

#pragma mark -
#pragma mark WEBVIEW DELEGATE METHODS

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
    [progressIndicator setHidden: NO];
    [progressIndicator startAnimation: self];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    [progressIndicator stopAnimation: self];
    [progressIndicator setHidden: YES];
}

@end
