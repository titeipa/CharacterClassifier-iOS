//
//  Point.m
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "Point.h"

@implementation WritingPoint

- (NSString*) toXml
{
    return [NSString stringWithFormat:@"<point>%f %f</point>", self.x, self.y];
}

@end
