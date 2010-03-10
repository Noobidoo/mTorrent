//
//  TableView.h
//  Rtorrent interface
//
//  Created by Noobidoo on 3/8/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XMLRPC/XMLRPC.h>

@interface TableView : NSObject <NSTableViewDataSource>{
 @private NSMutableArray* records;
}

@property(readwrite,assign) NSMutableArray* records;

-(void) addObject:(NSDictionary*)Dictionery;

-(void) addTest;
- (id)tableView:(NSTableView *)tableView 
objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(int)row;

- (int)numberOfRowsInTableView:(NSTableView *)tableView;
@end
