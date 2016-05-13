//
//  SlidingView.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "SlidingView.h"
#import "ForecastView.h"
#import "ForecastConditionDataModel.h"

static int TopViewHeight = 30;
static int BottomViewHeight = 60;
static int ScreenUIControlHeight = 60;
static int ScreenUIContentPadding = 10;

@implementation SlidingView {
    
    UIView *topView;
    UIView *middleView;
    UIView *bottomView;
    NSArray *arrayOfProductsRecieved;
//    UIButton *favButton;
//    NSMutableArray *dbReplica;
}



@synthesize horizontalScroller,pageControl;

-(instancetype) initWithFrame:(CGRect)frame andArray :(NSArray *)arrayOfProducts {
    
    self =[super initWithFrame:frame];
    if(self) {
        
        topView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, TopViewHeight)];
        [self addSubview:topView];
        
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - BottomViewHeight, self.frame.size.width, BottomViewHeight)];
        [self addSubview:bottomView];
        
        middleView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, topView.frame.origin.y + topView.frame.size.height, self.frame.size.width, self.frame.size.height - (TopViewHeight + BottomViewHeight))];
        [self addSubview:middleView];
        
        // PAGE CONTROL
        pageControl = [[UIPageControl alloc]initWithFrame:bottomView.bounds];
        [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
        [pageControl setNumberOfPages:[arrayOfProducts count]];
        [pageControl setCurrentPage:0];
        [bottomView addSubview:pageControl];
        
        //Middle View Subviews
        horizontalScroller = [[UIScrollView alloc] initWithFrame:middleView.frame];
//        [horizontalScroller setBackgroundColor:[UIColor orangeColor]];
        [horizontalScroller setPagingEnabled:TRUE];
        [horizontalScroller setShowsHorizontalScrollIndicator:FALSE];
        [horizontalScroller setDelegate:self];
        [self addSubview:horizontalScroller];
        
        arrayOfProductsRecieved = arrayOfProducts;
        
        [self createPaginatedPages];
    }
    
    return self;
}

-(void) createPaginatedPages {
    
    [arrayOfProductsRecieved enumerateObjectsUsingBlock:^(ForecastConditionDataModel *forecastNowShowing, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame;
        frame.origin.x = horizontalScroller.frame.size.width * idx + ScreenUIContentPadding;
        frame.origin.y = ScreenUIContentPadding;
        frame.size = CGSizeMake(horizontalScroller.frame.size.width - (ScreenUIContentPadding *2), horizontalScroller.frame.size.height - (ScreenUIContentPadding * 2));
        
        ForecastView *forecastToAdd = [[ForecastView alloc]initWithFrame:frame];
        
//        [[forecastToAdd code] setText:[[forecastNowShowing forecastConditionCode]stringValue]];
        [[forecastToAdd date] setText:[forecastNowShowing forecastConditionDate]];
        [[forecastToAdd day] setText:[forecastNowShowing forecastConditionDay]];
        [[forecastToAdd high] setText:[NSString stringWithFormat:@"High Temp : %@",[forecastNowShowing forecastConditionTemperatureHigh]]];
        [[forecastToAdd low] setText:[NSString stringWithFormat:@"Low Temp : %@",[forecastNowShowing forecastConditionTemperatureLow]]];
        [[forecastToAdd desc] setText:[forecastNowShowing forecastConditionDescription]];
        
        
        [[forecastToAdd layer] setCornerRadius:10.0f];
        [[forecastToAdd layer] setShadowColor:[UIColor blackColor].CGColor];
        [[forecastToAdd layer] setShadowOpacity:0.8];
        [[forecastToAdd layer] setShadowRadius:3.0];
        [[forecastToAdd layer] setShadowOffset:CGSizeMake(2.0, 2.0)];
        [forecastToAdd setClipsToBounds:TRUE];
        
        [horizontalScroller addSubview:forecastToAdd];
        
    }];
    
    [horizontalScroller setContentOffset:CGPointMake(horizontalScroller.frame.size.width * [pageControl currentPage], 0)];
    horizontalScroller.contentSize =  CGSizeMake(horizontalScroller.frame.size.width * [arrayOfProductsRecieved count], horizontalScroller.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = horizontalScroller.frame.size.width;
    float fractionalPage = horizontalScroller.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
}



-(void)dealloc {
    
    NSLog(@"dealloc");
//    NSLog(@"On dealloc dbReplica : %@",dbReplica);
//    [[NSUserDefaults standardUserDefaults] setObject:dbReplica forKey:@"Favorites"];
}

//-(void) updateButtonTitle {
//    
//    NSString *buttonTitle;
//    switch ([dbReplica containsObject:[NSNumber numberWithInteger:pageControl.currentPage]]) {
//        case 0:
//            buttonTitle = @"Add To Favorites";
//            break;
//        case 1:
//            buttonTitle = @"Remove To Favorites";
//            break;
//        default:
//            break;
//    }
//    
//    [favButton setTitle:buttonTitle forState:UIControlStateNormal];
//}

//-(void) favButtonPressed {
//    
//    
//    
//    if(![dbReplica containsObject:[NSNumber numberWithInteger:pageControl.currentPage]]) {
//        [dbReplica addObject:[NSNumber numberWithInteger:pageControl.currentPage]];
//        
//    }
//    else {
//        [dbReplica removeObject:[NSNumber numberWithInteger:pageControl.currentPage]];
//    }
//
//    [self updateButtonTitle];
//   
//}
@end
