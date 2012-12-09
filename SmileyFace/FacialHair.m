//
//  FacialHair.m
//  SmileyFace
//
//  Created by Stephanie Shupe on 8/21/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import "FacialHair.h"

@implementation FacialHair

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawMustache];
    // Drawing code
}


- (void) drawMustache {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, [self center].x + 30.0 , [self center].y + 30.0);
    CGContextAddLineToPoint(context, [self center].x - 30.0 , [self center].y + 30.0);
    CGContextAddLineToPoint(context, [self center].x - 30.0 , [self center].y - 30.0);
    
    CGContextFillPath(context);
}

@end
