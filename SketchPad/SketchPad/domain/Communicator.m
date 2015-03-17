//
//  Communicator.m
//  SketchPad
//
//  Created by Cosmin Titei on 09/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "Communicator.h"

#import "Communicator.h"

CFReadStreamRef readStream;
CFWriteStreamRef writeStream;

NSInputStream *inputStream;
NSOutputStream *outputStream;

@implementation Communicator

- (void)setup {
	NSURL *url = [NSURL URLWithString:host];
    CFStringRef remoteHost = (__bridge CFStringRef)(self->host);
	
	NSLog(@"Setting up connection to %@ : %i", [url absoluteString], port);
	
	CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, remoteHost, port, &readStream, &writeStream);
	
	if(!CFWriteStreamOpen(writeStream)) {
		NSLog(@"Error, writeStream not open");
		
		return;
	}
	[self open];
	
	NSLog(@"Status of outputStream: %lu", [outputStream streamStatus]);
	
	return;
}

- (void)open {
	NSLog(@"Opening streams.");
	
	inputStream = (__bridge NSInputStream *)readStream;
	outputStream = (__bridge NSOutputStream *)writeStream;
	
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	[inputStream open];
	[outputStream open];
}

- (void)close {
	NSLog(@"Closing streams.");
	
	[inputStream close];
	[outputStream close];
	
	[inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	
	[inputStream setDelegate:nil];
	[outputStream setDelegate:nil];
	
	inputStream = nil;
	outputStream = nil;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {
	NSLog(@"Stream triggered.");
	
	switch(event) {
		case NSStreamEventHasSpaceAvailable: {
			if(stream == outputStream) {
				NSLog(@"outputStream is ready.");
			}
			break;
		}
		case NSStreamEventHasBytesAvailable: {
			if(stream == inputStream) {
				NSLog(@"inputStream is ready.");
				
				uint8_t buf[1024];
                long int len = 0;
				
				len = [inputStream read:buf maxLength:1024];
				
				if(len > 0) {
					NSMutableData* data=[[NSMutableData alloc] initWithLength:0];
					
					[data appendBytes: (const void *)buf length:len];
					
					NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
					
					[self readIn:s];
				}
			}
			break;
		}
		default: {
			NSLog(@"Stream is sending an Event: %lu", event);
			
			break;
		}
	}
}

- (void)readIn:(NSString *)s {
	NSLog(@"Reading in the following:");
	NSLog(@"%@", s);
}

- (void)writeOut:(NSString *)s {
	uint8_t *buf = (uint8_t *)[s UTF8String];
	
	[outputStream write:buf maxLength:strlen((char *)buf)];
	
	NSLog(@"Writing out the following:");
	NSLog(@"%@", s);
}

@end
