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

- (id)init
{
 self = [super init];
 if (self) {
  records = [[NSMutableArray alloc]init];
 }
 return self;
}

- (void)dealloc{
 [records release];
 [super dealloc];
}

-(void) addObject:(NSDictionary*)Dictionery
{
 [records addObject:Dictionery];
}

-(void) addTest
{
 id theRecord;
 [records addObject:[[NSMutableDictionary alloc]init]];
  theRecord = [records lastObject];
 [theRecord setObject:@"mom" forKey:@"ID_1"];
}

- (id)tableView:(NSTableView *)tableView 
objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(int)row{
  id theRecord, theValue;
  
  NSParameterAssert(row >= 0 && row < [records count]);
  theRecord = [records objectAtIndex:row];
  theValue = [theRecord objectForKey:[tableColumn identifier]];
  return theValue;
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView{
 return ([records count]);
}
@end
