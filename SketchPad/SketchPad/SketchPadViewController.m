//
//  SketchPadViewController.m
//  SketchPad
//
//  Created by Cosmin Titei on 27/03/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "SketchPadViewController.h"
#import "SketchPadView.h"

@interface SketchPadViewController ()
@property (strong, nonatomic) IBOutlet SketchPadView *sketchPad;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;

@end

@implementation SketchPadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.communicator = [[Communicator alloc] init];
    self.communicator->host = @"192.168.1.101";
    self.communicator->port = 1234;
    
    [self.communicator setup];
    [self.communicator open];
}


- (IBAction)ColorButtonTouched:(UIButton*)sender
{
    self.sketchPad.drawColor = sender.backgroundColor;
}
- (IBAction)LineWidthSliderChanged:(UISlider *)sender
{
    self.sketchPad.lineWidth = sender.value;
}

- (void)awakeFromNib
{
    [self.lineWidthSlider setValue:self.sketchPad.lineWidth animated:NO];
}


- (IBAction)actiune:(UIButton *)sender {
    
}
- (IBAction)clearButtonTapped:(id)sender {
    [self.sketchPad clearWriting];
}
- (IBAction)recognizeButtonTapped:(UIButton *)sender {
    NSString *writingXml = [[self.sketchPad getWriting] toXml];
    [self.communicator writeOut:writingXml];
}

@end
