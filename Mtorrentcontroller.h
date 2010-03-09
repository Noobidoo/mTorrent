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
 IBOutlet NSTableView *Table;
 IBOutlet NSArrayController *arrayContacts;
@private NSURL* URL;
@private XMLRPCRequest* request;
@private XMLRPCConnectionManager* manager;
@private TableView* ViewData;
 NSMutableArray* torrents;
}
@property (readwrite,assign) NSURL* URL;
@property (readwrite,assign) XMLRPCRequest* request;
@property (readwrite,assign) XMLRPCConnectionManager* manager;
@property (readwrite,assign) TableView* ViewData;
@property (copy) NSMutableArray* torrents;
- (IBAction)GetHash:(id)sender;
- (IBAction)GetPath:(id)sender;
- (IBAction)ReloadTable:(id)sender;

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response;
- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error;
- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge;
- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge;
@end
