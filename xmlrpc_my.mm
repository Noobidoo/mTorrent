//
//  xmlrpc.m
//  Rtorrent interface
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import "xmlrpc_my.h"
#import "Mtorrentcontroller.h"
#include <XMLRPC/XMLRPC.h>

@implementation xmlrpc

@synthesize sVar;
@synthesize complete;

-(NSString *)Getxml:(NSString *)query whitDelegate:(id) delegate
{
 NSURL *URL=[NSURL URLWithString:@"http://192.168.1.107/RPC2"];
 XMLRPCRequest *request=[[XMLRPCRequest alloc] initWithURL:URL];
 XMLRPCConnectionManager *manager=[XMLRPCConnectionManager sharedManager];
 [request setMethod:query withParameter:@""];
 NSLog(@"Requested body:%@",[request body]);
 [manager spawnConnectionWithXMLRPCRequest: request delegate: delegate];
 [request release];
 return @"yey";
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
 if ([response isFault]) {
  NSLog(@"Fault code: %@", [response faultCode]);
  
  NSLog(@"Fault string: %@", [response faultString]);
 } else {
  NSLog(@"Parsed response: %@", [response object]);
  sVar=[response object];
  NSLog(@"Svar: %@",sVar);
  complete=true;
 }
 
 NSLog(@"Response body: %@", [response body]);
}
@end



///Old mac os carbon code
/*
 serverURL="http://192.168.1.107/RPC2";
 OSErr err;
 AEDesc targetAddress;
 
 NSAppleEventDescriptor* test =[[NSAppleEventDescriptor alloc]init];
 // Create the target address.
 //   Using type typeApplicationURL makes it a remote procedure call event.
 err = AECreateDesc(typeApplicationURL, serverURL, strlen(serverURL), &targetAddress);
 
 // Create an XML-RPC Apple event
 AppleEvent xmlrpcEvent;
 err = AECreateAppleEvent(kAERPCClass, kAEXMLRPCScheme, &targetAddress,
 kAutoGenerateReturnID, kAnyTransactionID, &xmlrpcEvent);
 AEDisposeDesc(&targetAddress);
 
 // Create the parameters for the event - the direct object is a record
 //   that contains the method name, and a list of parameters
 AEDesc directObject;
 err = AECreateList(NULL, 0, true, &directObject);
 
 // Insert the method name
 err = AEPutParamPtr(&directObject, keyRPCMethodName, typeChar,
 query, strlen(query));
 
 // Create the list for the actual parameters
 AEDesc paramList;
 err = AECreateList(NULL, 0, false, &paramList);
 
 // Put the state index into the parameter array
 char* stateIndex="started"; // Should correspond to South Dakota
 err = AEPutPtr(&paramList, 0, typeCString, stateIndex,
 sizeof(stateIndex));
 
 // Put the parameter list into the direct object
 err = AEPutParamDesc(&directObject, keyRPCMethodParam, &paramList);
 AEDisposeDesc(&paramList);
 
 // Put the direct object into the event
 err = AEPutParamDesc(&xmlrpcEvent, keyDirectObject, &directObject);
 AEDisposeDesc(&directObject);
 
 // Request all available debugging information. That will include
 //   the header and body for both the XML-RPC request and the reply
 //   from the server.
 SInt32 debugAttr = kAEDebugXMLDebugAll;
 err = AEPutAttributePtr(&xmlrpcEvent, keyXMLDebuggingAttr, typeSInt32,
 &debugAttr, sizeof(debugAttr));
 
 // Send the event
 AppleEvent replyEvent;
 AEInitializeDescInline(&replyEvent);
 err=AESendMessage(&xmlrpcEvent, &replyEvent, kAEWaitReply, kAEDefaultTimeout);
 
 // The direct object of the reply Apple event contains
 // our result (the name of the state)
 char buffer[255];
 Size actualSize;
 err = AEGetParamPtr(&replyEvent, keyDirectObject, typeChar, NULL,
 buffer, sizeof(buffer), &actualSize);
 
 fprintf(stderr, "State is %.*s!\n", (int)actualSize, buffer);
 
 // Dump debug information
 dumpDebug("HTTP POST header", &replyEvent, keyAEPOSTHeaderData);
 dumpDebug("XML Request", &replyEvent, keyAEXMLRequestData);
 dumpDebug("HTTP Reply header", &replyEvent, keyAEReplyHeaderData);
 dumpDebug("XML Reply", &replyEvent, keyAEXMLReplyData);
 
 return [NSString stringWithUTF8String:buffer];
 */
