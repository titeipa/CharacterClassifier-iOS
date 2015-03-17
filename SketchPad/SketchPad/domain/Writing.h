//
//  Writing.h
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stroke.h"

@interface Writing : NSObject

@property (strong, nonatomic) NSMutableArray* strokes;

- (void) addStroke:(Stroke*)stroke;
- (void) addPoint:(WritingPoint*)point;
- (NSString*) toXml;

@end
