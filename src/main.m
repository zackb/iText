//
//  main.m
//  iText
//
//  Created by Zack Bartel on 3/18/08.
//  Copyright Zack Bartel 2008. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AddressBook/AddressBook.h>
#import "ZBiPhoneDatabase.h"
#import "ZBSMSController.h"

int main(int argc, char *argv[])
{
/*
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *array = [ZBiPhoneDatabase allDatabases];

    ZBiPhoneDatabase *db = [array objectAtIndex: 0];
    
    ZBSMSController *controller = [[ZBSMSController alloc] initWithDatabase: db];
    
    [controller load];
    
    [pool release];
    
    return 0;
*/

    return NSApplicationMain(argc,  (const char **) argv);
}
