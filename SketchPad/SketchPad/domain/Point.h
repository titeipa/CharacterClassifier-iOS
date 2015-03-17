//
//  Point.h
//  SketchPad
//
//  Created by Cosmin Titei on 08/06/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WritingPoint : NSObject

@property CGFloat x, y;

- (NSString*)toXml;

@end
