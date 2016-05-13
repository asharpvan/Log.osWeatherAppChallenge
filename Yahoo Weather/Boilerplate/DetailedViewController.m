//
//  DetailedViewController.m
//  Boilerplate
//
//  Created by agatsa on 5/13/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "DetailedViewController.h"
#import "SlidingView.h"
#import "Chameleon.h"

@interface DetailedViewController (){
    
    SlidingView *slidingView;
    NSArray *arrayRecieved;
//    NSInteger currentPageRecieved;
    
}


@end

@implementation DetailedViewController

-(instancetype) initWithArray:(NSArray *) arrayPassed  {
    
    self = [super init];
    if(self) {
        
        [self setTitle:@"Detailed View"];
        [self.view setBackgroundColor:[UIColor flatSandColor]];
        arrayRecieved = arrayPassed;
//        currentPageRecieved = currentPagePassed;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    [self createSubview];
}

-(void)createSubview {
    
    
    CGFloat navBarHeightPlusStatusBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication]statusBarFrame].size.height;
    
    slidingView = [[SlidingView alloc]initWithFrame:CGRectMake(0, navBarHeightPlusStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navBarHeightPlusStatusBarHeight) andArray:arrayRecieved];
    [self.view addSubview:slidingView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
