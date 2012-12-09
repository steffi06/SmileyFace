//
//  SmileyFace.m
//  SmileyFace
//
//  Created by Stephanie Shupe on 8/21/12.
//  Copyright (c) 2012 BurnOffBabes. All rights reserved.
//

#import "SmileyFace.h"
#import "FacialHair.h"

@interface SmileyFace ()

@property CGPoint boundsCenter;

@property CGPoint controlPointModifyMouth;

@property FacialHair *facialHairView;

@end

@implementation SmileyFace
@synthesize controlPointModifyMouth = _controlPointModifyMouth;

- (void) awakeFromNib
{
    [super awakeFromNib];
    _controlPointModifyMouth.x = self.bounds.origin.x + self.bounds.size.width/2.0;
    _controlPointModifyMouth.y = self.bounds.origin.y + self.bounds.size.height/2.0 + 120.0;
    
    UIButton *facialHairButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [facialHairButton addTarget:self action:@selector(toggleFacialHair) forControlEvents:UIControlEventTouchUpInside];
    [facialHairButton setTitle:@"Add Facial Hair" forState:UIControlStateNormal];
    facialHairButton.frame = CGRectMake([self center].x, [self center].y + 175.0 , 120.0 , 50.0);

    [self addFacialHair];
    [self addSubview:facialHairButton];

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawHead];
    [self drawEyes];
    [self drawNose];
    [self drawMouth];
    [self drawEyebrows];

}




- (void)drawHead {
    //first set context to current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //make radius of circle relative to size of bounds in view
    float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height)/4.0;
    
    //set thickness of line
    CGContextSetLineWidth(context, 10);
    
    //set color
    [[self randomColor] set];
    
    //make arc 0 to 2PI -- in other words a CIRCLE!
    CGContextAddArc(context, [self center].x, [self center].y, maxRadius, 0.0, M_PI * 2.0, YES);
    
    //draw stroke!
    CGContextStrokePath(context);
}


- (void)drawEyes {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height)/4.0;
    
    //right eye
    CGPoint rightEye;
    rightEye.x = [self center].x + maxRadius/3.0;
    rightEye.y = [self center].y - maxRadius/4.0;
    
    CGContextAddArc(context, rightEye.x, rightEye.y , maxRadius/8.0 , 0.0, 2.0 * M_PI , YES);
    
    
    [[self randomColor] set];
    CGContextFillPath(context);
    
    //left eye
    CGPoint leftEye;
    leftEye.x = [self center].x - maxRadius/3.0;
    leftEye.y = [self center].y - maxRadius/4.0;
    
    CGContextAddArc(context, leftEye.x, leftEye.y , maxRadius/8.0 , 0.0, 2.0 * M_PI , YES);
    
    
    [[self randomColor] set];
    CGContextFillPath(context);
    
}


- (void)drawNose {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint startOfNose;
    startOfNose.x = [self center].x + 20.0;
    startOfNose.y = [self center].y + 35.0;
    
    CGContextMoveToPoint(context, startOfNose.x, startOfNose.y);
    
    CGContextAddLineToPoint(context, (startOfNose.x - 30.0) , startOfNose.y);
    
    CGContextAddLineToPoint(context, [self center].x , startOfNose.y - 50.0);
    
    [[self randomColor] set];
    CGContextStrokePath(context);
    
    
}


- (void)drawMouth {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint startOfMouth;
    startOfMouth.x = [self center].x + 60.0;
    startOfMouth.y = [self center].y + 75.0;
    
    CGContextMoveToPoint(context, startOfMouth.x, startOfMouth.y);
    
//    CGContextAddLineToPoint(context, startOfMouth.x + 15.0 , startOfMouth.y + 15.0 );

    
    CGContextAddQuadCurveToPoint(context, _controlPointModifyMouth.x, _controlPointModifyMouth.y, [self center].x - 60.0 , startOfMouth.y);
    
    
    [[self randomColor] set];
    CGContextStrokePath(context);
    
}


- (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random()/INT_MAX green:arc4random()/INT_MAX blue:arc4random()/INT_MAX alpha:1];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _controlPointModifyMouth.x = [[touches anyObject] locationInView:self].x;
    _controlPointModifyMouth.y = [[touches anyObject] locationInView: self].y;
    [self setNeedsDisplay];
}



- (void)drawEyebrows{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint startOfRightEyebrow;
    startOfRightEyebrow.x = [self center].x + 80.0;
    startOfRightEyebrow.y = [self center].y - 65.0;
    
    CGContextMoveToPoint(context, startOfRightEyebrow.x, startOfRightEyebrow.y);
    
    CGContextAddQuadCurveToPoint(context, [self center].x, [self center].y - 120.0, [self center].x + 15.0, startOfRightEyebrow.y);
    [[self randomColor] set];
    CGContextStrokePath(context);
    
    CGPoint startOfLeftEyebrow;
    startOfLeftEyebrow.x = [self center].x - 80.0;
    startOfLeftEyebrow.y = [self center].y - 65.0;
    
    CGContextMoveToPoint(context, startOfLeftEyebrow.x, startOfLeftEyebrow.y);
    
    CGContextAddQuadCurveToPoint(context, [self center].x, [self center].y - 120.0, [self center].x - 15.0, startOfLeftEyebrow.y);
    [[self randomColor] set];
    CGContextStrokePath(context);
}


- (void)addFacialHair{
    self.facialHairView = [[FacialHair alloc] initWithFrame:CGRectMake([self center].x - 15.0 , [self center].y + 70.0, 40.0, 15.0)];
    [self addSubview:self.facialHairView];
}

- (void)toggleFacialHair{
    self.facialHairView.hidden = !(self.facialHairView.hidden);
}


@end
