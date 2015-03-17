//
//  SketchPadViewController.h
//  SketchPad
//
//  Created by Cosmin Titei on 27/03/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Communicator.h"

@interface SketchPadViewController : UIViewController
@property (strong, nonatomic) Communicator *communicator;
@end
