//
//  IndexCell.m
//  Splint
//
//  Created by William Gestrich on 11/16/13.
//  Copyright (c) 2013 William Gestrich. All rights reserved.
//

#import "IndexCell.h"

@implementation IndexCell

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){

    }
    
    return self;
}

-(void)layoutSubviews{
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    self.layer.shadowRadius = 5.0f;
    self.layer.masksToBounds = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = path.CGPath;
    
    self.layer.shouldRasterize = YES;
}


@end
