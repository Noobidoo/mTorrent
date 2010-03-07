//
//  xmlrpc.h
//  Rtorrent interface
//
//  Created by Noobidoo on 3/6/10.
//  Copyright 2010 Novia. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XMLRPC/XMLRPC.h>

@interface xmlrpc :NSObject{
 @private NSString *sVar;
 bool complete;
}
@property (readwrite,assign) bool complete;
@property (readwrite, assign) NSString *sVar;
- (NSString *)Getxml:(NSString *)query whitDelegate:(id) delegate;
- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response;
@end
