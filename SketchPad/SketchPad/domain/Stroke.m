//
//  Stroke.m
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "Stroke.h"


@implementation Stroke

- (void)addPoint:(WritingPoint*)point
{
    if (!self.points) self.points = [NSMutableArray array];
    [self.points addObject:point];
}


- (NSString*) toXml
{
    NSString* xml = @"<stroke>";
    for (WritingPoint* point in self.points) {
        xml = [xml stringByAppendingString:[point toXml]];
    }
    return [xml stringByAppendingString:@"</stroke>"];
}

@end
