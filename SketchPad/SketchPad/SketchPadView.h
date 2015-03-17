//
//  SketchPadView.h
//  SketchPad
//
//  Created by Cosmin Titei on 28/03/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Writing.h"

@interface SketchPadView : UIView

@property (nonatomic) UIColor *drawColor;
@property (nonatomic) CGFloat lineWidth;

- (Writing*) getWriting;
- (void) clearWriting;

@end
