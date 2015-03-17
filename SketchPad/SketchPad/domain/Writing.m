//
//  Writing.m
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "Writing.h"

@implementation Writing

- (void)addStroke:(Stroke*)stroke
{
    [self.strokes addObject:stroke];
}

- (void)addPoint:(WritingPoint *)point
{
    [[self.strokes lastObject] addPoint:point];
}

- (NSMutableArray*) strokes {
    if (!_strokes) _strokes = [NSMutableArray array];
    return _strokes;
}

- (NSString*)toXml
{
    NSString* xml = @"<writing type=\"digit\">";
    for (Stroke* stroke in self.strokes) {
        xml = [xml stringByAppendingString:[stroke toXml]];
    }
    return [xml stringByAppendingString:@"</writing>"];
}

@end
