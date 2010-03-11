//
//  Mtorrentcontroller.m
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import "Mtorrentcontroller.h"
#import <XMLRPC/XMLRPC.h>
#import "TableView.h"

@implementation Mtorrentcontroller

@synthesize myTable;

@synthesize URL;
@synthesize manager;
@synthesize torrents;

- (id)init
{
 self = [super init];
 if (self) {
  URL=[NSURL URLWithString:@"http://noobs.gotdns.org/RPC2"];
  [URL retain];
  manager=[XMLRPCConnectionManager sharedManager];
  torrents  = [[NSMutableArray alloc] init];
 }
 return self;
}

- (void)awakeFromNib {
 mViewData = [myTable dataSource];
}
- (void)dealloc{
 [URL release];
 [super dealloc];
 
}

- (IBAction)GetHash:(id)sender {
 myrequest=[[XMLRPCRequest alloc] initWithURL:URL];
 NSArray* Parameters =[NSArray arrayWithObjects:@"",@"d.get_name=",@"d.get_base_path=",@"d.get_hash=",nil];
 [myrequest setMethod:@"d.multicall" withParameter:Parameters];
 NSLog(@"Sent: %@",[myrequest body]);
 [manager spawnConnectionWithXMLRPCRequest: myrequest delegate: self];
 [myrequest release];
}
- (IBAction)GetPath:(id)sender {
 NSArray* m =[NSArray arrayWithObjects:@"Name",@"Path",@"Hash",nil];
 NSArray* keys =[NSArray arrayWithObjects:@"Name",@"Path",@"Hash",nil];
 NSDictionary* dict=[NSDictionary dictionaryWithObjects:m forKeys:keys];
 [mViewData myaddObject:dict to:myTable];
 [myTable reloadData];
}


- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
 if ([response isFault]) {
  NSLog(@"Fault code: %@", [response faultCode]);
  
  NSLog(@"Fault string: %@", [response faultString]);
 } else {
  if ([request.method isEqualToString:@"d.multicall"]) {
   for (NSArray* m in [NSArray arrayWithArray:[response object]]) {
    NSArray* keys =[NSArray arrayWithObjects:@"Name",@"Path",@"Hash",nil];
    NSDictionary* dict=[NSDictionary dictionaryWithObjects:m forKeys:keys];
    [mViewData myaddObject:dict to:myTable];
   }
  }
  [myTable reloadData];
 }
 
}

- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error
{
 NSLog(@"Error description: %@", [error localizedDescription]);
}
- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{}
- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{}

@end
