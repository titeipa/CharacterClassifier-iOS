//
//  Stroke.h
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Point.h"

@interface Stroke : NSObject
@property (strong, atomic) NSMutableArray* points;

- (void) addPoint:(WritingPoint*)point;
- (NSString*) toXml;

@end
