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
 IBOutlet NSTableView *myTable;
 @private NSMutableDictionary* records;
}
@property(readwrite,assign) NSMutableDictionary* records;
@property (assign) NSTableView* myTable;
- (IBAction)reloadTableView:(id)sender;
- (IBAction)doubleClickAction:(id)sender;
-(void) myaddObject:(NSDictionary*)Dictionery to:(NSTableView*) tableView;
@end

@interface TableView (NSTableViewDelegate) <NSTableViewDelegate>
- (id)tableView:(NSTableView *)tableView 
objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(int)row;

- (int)numberOfRowsInTableView:(NSTableView *)tableView;
@end