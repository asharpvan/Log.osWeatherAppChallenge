//
//  ForecastView.m
//  Boilerplate
//
//  Created by agatsa on 5/13/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ForecastView.h"
static int padding = 5;
@implementation ForecastView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.date = [[UILabel alloc]initWithFrame: CGRectMake(0, padding, frame.size.width, 40)];
        [self.date setTextAlignment:NSTextAlignmentCenter];
        [self.date setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:self.date];
        
        self.day = [[UILabel alloc]initWithFrame: CGRectMake(0, self.date.frame.origin.y + self.date.frame.size.height + padding, frame.size.width, 40)];
        [self.day setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.day];
        
        self.high = [[UILabel alloc]initWithFrame: CGRectMake(0, self.day.frame.origin.y + self.day.frame.size.height + padding, frame.size.width, 40)];
        [self.high setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.high];
        
        self.low = [[UILabel alloc]initWithFrame: CGRectMake(0, self.high.frame.origin.y + self.high.frame.size.height + padding, frame.size.width, 40)];
        [self.low setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.low];
        
        self.desc = [[UILabel alloc]initWithFrame: CGRectMake(0, self.low.frame.origin.y + self.low.frame.size.height + padding, frame.size.width, 40)];
        [self.desc setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.desc];
    }
    
    return self;
}
@end
