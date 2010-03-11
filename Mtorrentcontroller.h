//
//  Mtorrentcontroller.h
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XMLRPC/XMLRPC.h>
#import "TableView.h"

@interface Mtorrentcontroller : NSObject <XMLRPCConnectionDelegate>{
 IBOutlet NSTableView *myTable;
 IBOutlet NSTextField *myTextview;
@private NSURL* URL;
@private XMLRPCRequest* myrequest;
@private XMLRPCConnectionManager* manager;
 TableView* mViewData;
 NSMutableArray* torrents;
}
@property (assign) NSTableView* myTable;
@property (readwrite,assign) NSURL* URL;
@property (readwrite,assign) XMLRPCConnectionManager* manager;
@property (copy) NSMutableArray* torrents;
- (IBAction)requestUpdate:(id)sender;
- (IBAction)GetPath:(id)sender;
- (IBAction)doubleClickAction:(id)sender;

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response;
- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error;
- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge;
- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge;
@end
