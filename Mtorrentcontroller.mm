//
//  Mtorrentcontroller.m
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import "Mtorrentcontroller.h"
#import <XMLRPC/XMLRPC.h>

@implementation Mtorrentcontroller

@synthesize URL;
@synthesize request;
@synthesize manager;
@synthesize ViewData;
@synthesize torrents;

- (id)init
{
 self = [super init];
 if (self) {
  URL=[NSURL URLWithString:@"http://noobs.gotdns.org/RPC2"];
  [URL retain];
  manager=[XMLRPCConnectionManager sharedManager];
  ViewData=[ViewData init];
  torrents  = [[NSMutableArray alloc] init];

 }
 return self;
}

- (void)dealloc{
 [URL release];
 [ViewData release];
 [super dealloc];
 
}
- (IBAction)GetHash:(id)sender {
 request=[[XMLRPCRequest alloc] initWithURL:URL];
 NSArray* Parameters =[NSArray arrayWithObjects:@"",@"d.get_name=",@"d.get_base_path=",@"d.get_hash=",nil];
 [request setMethod:@"d.multicall" withParameter:Parameters];
 [manager spawnConnectionWithXMLRPCRequest: request delegate: self];
 [request release]; 
}
- (IBAction)GetPath:(id)sender {
 
}

- (IBAction)ReloadTable:(id)sender {
 NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:
                      @"./", @"Path",
                      @"non", @"Name",
                      @"95749389gfd8fgg8f", @"Hash",
                      nil];
 
 //add it to the arrayController
 [arrayContacts addObject:dict];
}


- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
 if ([response isFault]) {
  NSLog(@"Fault code: %@", [response faultCode]);
  
  NSLog(@"Fault string: %@", [response faultString]);
 } else {
  [arrayContacts removeObjects:[arrayContacts arrangedObjects]];
  for (NSArray* m in [NSArray arrayWithArray:[response object]]) {
   NSArray* keys =[NSArray arrayWithObjects:@"Name",@"Path",@"Hash",nil];
   NSDictionary* dict=[NSDictionary dictionaryWithObjects:m forKeys:keys];
   [arrayContacts addObject:dict];
  }
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
