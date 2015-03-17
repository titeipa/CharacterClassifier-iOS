//
//  SketchPadView.m
//  SketchPad
//
//  Created by Cosmin Titei on 28/03/14.
//  Copyright (c) 2014 Paul Titei. All rights reserved.
//

#import "SketchPadView.h"

@interface SketchPadView ()
@property (nonatomic) Writing* writing;
@end

@implementation SketchPadView

- (Writing*) writing {
    if (!_writing) _writing = [[Writing alloc] init];
    return _writing;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setDrawColor:(UIColor *)drawColor
{
    _drawColor = drawColor;
    [self setNeedsDisplay];
}

- (Writing*) getWriting
{
    return self.writing;
}

- (void)clearWriting
{
    self.writing = [[Writing alloc] init];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    Stroke *stroke = [[Stroke alloc] init];
    WritingPoint *point = [[WritingPoint alloc]init];
    point.x = location.x;
    point.y = location.y;
    [stroke addPoint:point];
    [self.writing addStroke:stroke];
    
    [self setNeedsDisplay];
    
    //[self.path removeAllPoints];
    //[self.path moveToPoint:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    WritingPoint *point = [[WritingPoint alloc]init];
    point.x = location.x;
    point.y = location.y;
    [self.writing addPoint:point];
    
//    [self.path addLineToPoint:location];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    for (int i = 0; i < [self.writing.strokes count]; i++) {
        Stroke *stroke = self.writing.strokes[i];
        for (int j = 0; j < [stroke.points count]; j++) {
            WritingPoint *point = stroke.points[j];
            CGPoint cgpoint = CGPointMake(point.x, point.y);
            if (j == 0) {
                [path moveToPoint:cgpoint];
            } else {
                [path addLineToPoint:cgpoint];
            }
        }
    }
    [self.drawColor setStroke];
    [path setLineWidth:self.lineWidth];
    [path stroke];
}

const int DEFAULT_LINE_WIDTH = 1.0;

- (void)awakeFromNib
{
    self.drawColor = [UIColor blackColor];
    self.lineWidth = DEFAULT_LINE_WIDTH;
}

@end
