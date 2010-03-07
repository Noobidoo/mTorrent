//
//  Mtorrentcontroller.m
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import "Mtorrentcontroller.h"
#import "xmlrpc_my.h"

@implementation Mtorrentcontroller
- (IBAction)GetHash:(id)sender {
 NSURL *URL=[NSURL URLWithString:@"http://192.168.1.107/RPC2"];
 XMLRPCRequest *request=[[XMLRPCRequest alloc] initWithURL:URL];
 XMLRPCConnectionManager *manager=[XMLRPCConnectionManager sharedManager];
 NSArray* test =[NSArray arrayWithObjects:@"",@"d.get_name=",nil];
 [request setMethod:@"d.multicall" withParameter:test];
 NSLog(@"Requested body:%@",[request body]);
 [manager spawnConnectionWithXMLRPCRequest: request delegate: self];
 [request release];

}
- (IBAction)GetPath:(id)sender {
 
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
 if ([response isFault]) {
  NSLog(@"Fault code: %@", [response faultCode]);
  
  NSLog(@"Fault string: %@", [response faultString]);
 } else {
  NSLog(@"Parsed response: %@", [response object]);
  [display setStringValue:[response object]];
 }
 
 NSLog(@"Response body: %@", [response body]);
 
}

- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error
{
 NSLog(@"Error description: %@", [error localizedDescription]);
}
- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{}
- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{}
- (void) parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qualifiedName 
     attributes:(NSDictionary *)attributeDict
{
 NSLog(@"Started parsing %@", elementName);
}
@end
