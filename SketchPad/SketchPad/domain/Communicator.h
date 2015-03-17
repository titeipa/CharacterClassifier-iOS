//
//  Communicator.h
//  SketchPad
//
//  Created by Cosmin Titei on 09/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Communicator : NSObject <NSStreamDelegate> {
@public
	
	NSString *host;
	int port;
}

- (void)setup;
- (void)open;
- (void)close;
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event;
- (void)readIn:(NSString *)s;
- (void)writeOut:(NSString *)s;

@end