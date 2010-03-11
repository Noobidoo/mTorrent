//
//  TableView.m
//  Rtorrent interface
//
//  Created by Noobidoo on 3/8/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import "TableView.h"


@implementation TableView

@synthesize records;
@synthesize myTable;
- (id)init
{
 self = [super init];
 if (self) {
  records = [[NSMutableDictionary alloc]init];
  [records setObject:[NSMutableArray array] forKey:@"1"];
  [records setObject:[NSMutableArray array] forKey:@"2"];
 }
 return self;
}

- (IBAction)reloadTableView:(id)sender
{
 [myTable reloadData];
}

- (void)dealloc{
 [records release];
 [super dealloc];
}

-(void) myaddObject:(NSDictionary*)Dictionery to:(NSTableView*) tableView;
{
 id theRecord=[records valueForKey:[tableView autosaveName]];
 [theRecord addObject:Dictionery];
}

- (IBAction)doubleClickAction:(id)sender {
 NSLog(@"The table view %@ has been double-clicked!", sender);
 id theRecord,tableRecords;
 int row=[sender clickedRow];
 tableRecords=[records valueForKey:[sender autosaveName]];
 NSParameterAssert(row >= 0 && row < [tableRecords count]);
 theRecord = [tableRecords objectAtIndex:row];
 NSLog(@"The table view %@ has been double-clicked!", [theRecord objectForKey:@"Name"]);
}

@end
@implementation TableView (NSTableViewDelegate)
- (id)tableView:(NSTableView *)tableView 
objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(int)row{
 
 id theRecord, theValue,tableRecords;
 tableRecords=[records valueForKey:[tableView autosaveName]];
 NSParameterAssert(row >= 0 && row < [tableRecords count]);
 theRecord = [tableRecords objectAtIndex:row];
 theValue = [theRecord objectForKey:[tableColumn identifier]];
 return theValue;
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView{
 return ([[records valueForKey:[tableView autosaveName]] count]);
}
@end
