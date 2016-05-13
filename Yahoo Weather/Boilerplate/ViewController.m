//
//  ViewController.m
//  Boilerplate
//
//  Created by agatsa on 4/1/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "ViewController.h"
#import "YahooWeatherClient.h"
#import "DetailedViewController.h"
#import "CityDataModel.h"
#import "CurrentCoditionsDataModel.h"
#import "Chameleon.h"


static int Padding = 10;


@interface ViewController () {
    
    UIActivityIndicatorView *fetcActivityIndicator;
    UIButton *reloadButton;
    UIButton *forecastButton;
    UILabel *errorLabel;
    NSArray *arrayToPass;
}

@end

@implementation ViewController

-(instancetype) init {
    
    self = [super init];
    if(self) {
       
        [self setTitle:@"Yahoo Weather"];
        [self.view setBackgroundColor:[UIColor whiteColor]];

        fetcActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [fetcActivityIndicator setCenter:self.view.center];
        [fetcActivityIndicator setHidesWhenStopped:TRUE];
        [self.view addSubview:fetcActivityIndicator];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    if(!arrayToPass)
        [self startFetching];
}

-(void)createSubview : (CityDataModel *)city {

    
    NSLog(@"Create Subview");
    
    UIView *cityDetailsView = [[UIView alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, (self.view.frame.size.height - 70)/3)];
    [[cityDetailsView layer] setCornerRadius:10.0f];
    [cityDetailsView setBackgroundColor:[UIColor flatSandColor]];
    [self.view addSubview:cityDetailsView];
    
    UIView *currentConditionsView = [[UIView alloc] initWithFrame:CGRectMake(0, cityDetailsView.frame.origin.y + cityDetailsView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - (cityDetailsView.frame.size.height + 120))];
    [self.view addSubview:currentConditionsView];
    
    forecastButton = [[UIButton alloc]initWithFrame:CGRectMake(0, currentConditionsView.frame.origin.y + currentConditionsView.frame.size.height, self.view.frame.size.width/2, 44)];
    [forecastButton setTitle:@"forecast" forState:UIControlStateNormal];
    [forecastButton addTarget:self action:@selector(showForecast) forControlEvents:UIControlEventTouchUpInside];
    [forecastButton setBackgroundColor:[UIColor blueColor]];
    [forecastButton setCenter:CGPointMake(self.view.center.x, forecastButton.center.y)];
    [self.view addSubview:forecastButton];
    
    //City Details Subviews
    UILabel *cityNameRegionCountryLabel = [[UILabel alloc]initWithFrame:CGRectMake(Padding, Padding, (cityDetailsView.frame.size.width - (2 * Padding)), 100)];
    [cityNameRegionCountryLabel setTextAlignment:NSTextAlignmentCenter];
    [cityNameRegionCountryLabel setNumberOfLines:0];
    [cityNameRegionCountryLabel setText:[NSString stringWithFormat:@"%@\n%@\n%@",[city cityName],[city cityRegion],[city cityCountry]]];
//    [cityNameRegionCountryLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [cityDetailsView addSubview:cityNameRegionCountryLabel];
    
    UIImageView *locationMarker = [[UIImageView alloc]initWithFrame:CGRectMake(70, cityNameRegionCountryLabel.frame.origin.y + cityNameRegionCountryLabel.frame.size.height + Padding, 20, 20)];
    [locationMarker setImage:[UIImage imageNamed:@"location.png"]];
    [cityDetailsView addSubview:locationMarker];
    
    UILabel *latLongLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationMarker.frame.origin.x + locationMarker.frame.size.width + Padding/2, 0, 180, 44)];
//    [latLongLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [latLongLabel setText:[NSString stringWithFormat:@"%@, %@",[city cityLatitude],[city cityLongitude]]];
    [latLongLabel setCenter:CGPointMake(latLongLabel.center.x, locationMarker.center.y)];
    [cityDetailsView addSubview:latLongLabel];
    
    //City Details Subviews
    UILabel *currentConditionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(Padding, Padding, (currentConditionsView.frame.size.width - (2 * Padding)), 44)];
    [currentConditionsLabel setTextAlignment:NSTextAlignmentCenter];
    
//    [currentConditionsLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[currentConditionsView backgroundColor]]];
    [currentConditionsView addSubview:currentConditionsLabel];
    
    
    UILabel *currentTempLabel = [[UILabel alloc]initWithFrame:CGRectMake(Padding, currentConditionsLabel.frame.size.height + currentConditionsLabel.frame.origin.y, (currentConditionsView.frame.size.width - (2 * Padding))/2, 100)];
    [currentTempLabel setTextAlignment:NSTextAlignmentCenter];
    [currentTempLabel setText:[NSString stringWithFormat:@"%@ %@",city.currentConditions.currentConditionTemperature,city.currentConditions.currentConditionTempUnit]];
//    [currentTempLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[UIColor greenColor]]];
    [currentConditionsView addSubview:currentTempLabel];
    
    UIView *currentTempDescriptionView = [[UIView alloc]initWithFrame:CGRectMake(currentTempLabel.frame.size.width + currentTempLabel.frame.origin.x,currentTempLabel.frame.origin.y, currentTempLabel.frame.size.width, currentTempLabel.frame.size.height)];
//    [currentTempDescriptionView setBackgroundColor:[UIColor blueColor]];
    [currentConditionsView addSubview:currentTempDescriptionView];
    
    
    UIImageView *conditionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Padding * 6,Padding/2, 40, 40)];
//    [conditionImageView setBackgroundColor:[UIColor orangeColor]];
    [currentTempDescriptionView addSubview:conditionImageView];
    
    UILabel *currentTempDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(Padding, currentTempDescriptionView.frame.size.height - 50, currentTempDescriptionView.frame.size.width - (2 * Padding), 44)];
    [currentTempDescLabel setTextAlignment:NSTextAlignmentCenter];
//    [currentTempDescLabel setBackgroundColor:[UIColor greenColor]];
    [currentTempDescLabel setText:city.currentConditions.currentConditionWeatherDescription];
    [currentTempDescriptionView addSubview:currentTempDescLabel];
    
    UIImageView *windMarker = [[UIImageView alloc]initWithFrame:CGRectMake(Padding/2, currentTempLabel.frame.origin.y + currentTempLabel.frame.size.height + Padding, 20, 20)];
    [windMarker setImage:[UIImage imageNamed:@"wind.png"]];
    [currentConditionsView addSubview:windMarker];
    
    UILabel *windLabel = [[UILabel alloc]initWithFrame:CGRectMake(windMarker.frame.origin.x + windMarker.frame.size.width, 0, currentConditionsView.frame.size.width/2 - (windMarker.frame.origin.x + windMarker.frame.size.width), 44)];
    [windLabel setText:[NSString stringWithFormat:@"%@ %@",city.currentConditions.currentConditionWindSpeed,city.currentConditions.currentConditionSpeedUnit]];
//    [windLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [windLabel setCenter:CGPointMake(windLabel.center.x, windMarker.center.y)];
    [currentConditionsView addSubview:windLabel];

    UIImageView *humidityMarker = [[UIImageView alloc]initWithFrame:CGRectMake(windLabel.frame.origin.x + windLabel.frame.size.width, windMarker.frame.origin.y, 20, 20)];
    [humidityMarker setImage:[UIImage imageNamed:@"humidity.png"]];
    [currentConditionsView addSubview:humidityMarker];
    
    UILabel *humidityLabel = [[UILabel alloc]initWithFrame:CGRectMake(humidityMarker.frame.origin.x + humidityMarker.frame.size.width, 0, windLabel.frame.size.width, windLabel.frame.size.height)];
    [humidityLabel setText:city.currentConditions.currentConditionHumidity];
//    [humidityLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [humidityLabel setCenter:CGPointMake(humidityLabel.center.x, humidityMarker.center.y)];
    [currentConditionsView addSubview:humidityLabel];
   
    UIImageView *sunriseMarker = [[UIImageView alloc]initWithFrame:CGRectMake(windMarker.frame.origin.x, humidityLabel.frame.origin.y + humidityLabel.frame.size.height + Padding, 20, 20)];
    [sunriseMarker setImage:[UIImage imageNamed:@"sunrise.png"]];
    [currentConditionsView addSubview:sunriseMarker];
    
    UILabel *sunriseLabel = [[UILabel alloc]initWithFrame:CGRectMake(sunriseMarker.frame.origin.x + sunriseMarker.frame.size.width, 0, currentConditionsView.frame.size.width/2 - (sunriseMarker.frame.origin.x + sunriseMarker.frame.size.width), 44)];
    [sunriseLabel setText:city.currentConditions.currentConditionSunriseTime];
//    [sunriseLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [sunriseLabel setCenter:CGPointMake(sunriseLabel.center.x, sunriseMarker.center.y)];
    [currentConditionsView addSubview:sunriseLabel];

    UIImageView *sunsetMarker = [[UIImageView alloc]initWithFrame:CGRectMake(sunriseLabel.frame.origin.x + sunriseLabel.frame.size.width, sunriseMarker.frame.origin.y, 20, 20)];
    [sunsetMarker setImage:[UIImage imageNamed:@"sunset.png"]];
    [currentConditionsView addSubview:sunsetMarker];
    
    UILabel *sunsetLabel = [[UILabel alloc]initWithFrame:CGRectMake(sunsetMarker.frame.origin.x + sunsetMarker.frame.size.width, 0, sunriseLabel.frame.size.width, sunriseLabel.frame.size.height)];
    [sunsetLabel setText:city.currentConditions.currentConditionSunsetTime];
//    [sunsetLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [sunsetLabel setCenter:CGPointMake(sunsetLabel.center.x, sunsetMarker.center.y)];
    [currentConditionsView addSubview:sunsetLabel];

    UIImageView *visibilityMarker = [[UIImageView alloc]initWithFrame:CGRectMake(80, sunsetLabel.frame.origin.y + sunsetLabel.frame.size.height + Padding, 20, 20)];
    [visibilityMarker setImage:[UIImage imageNamed:@"visibility.png"]];
    [currentConditionsView addSubview:visibilityMarker];
    
    UILabel *visibilityLabel = [[UILabel alloc]initWithFrame:CGRectMake(visibilityMarker.frame.origin.x + visibilityMarker.frame.size.width, 0, windLabel.frame.size.width, 44)];
    [visibilityLabel setText:city.currentConditions.currentConditionVisibility];
//    [visibilityLabel setBackgroundColor:[UIColor colorWithComplementaryFlatColorOf:[cityDetailsView backgroundColor]]];
    [visibilityLabel setCenter:CGPointMake(visibilityLabel.center.x, visibilityMarker.center.y)];
    [currentConditionsView addSubview:visibilityLabel];
    
}

-(void) showError:(NSString *)errorString {
    
    NSLog(@"Error is :%@",errorString);
    
    errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 100)];
    [errorLabel setText:errorString];
    [errorLabel setNumberOfLines:0];
    [errorLabel setTextAlignment:NSTextAlignmentCenter];
    [errorLabel setCenter:self.view.center];
    [self.view addSubview:errorLabel];
    
    reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, errorLabel.frame.size.width/2, 44)];
    [reloadButton setTitle:@"Reload" forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(reFetch) forControlEvents:UIControlEventTouchUpInside];
    [reloadButton setBackgroundColor:[UIColor blueColor]];
    [reloadButton setCenter:CGPointMake(self.view.center.x, errorLabel.center.y + 60)];
    [self.view addSubview:reloadButton];
    
}

-(void) startFetching {
    
    NSLog(@"startFetching");
    
    [fetcActivityIndicator startAnimating];
    
    [YahooWeatherClient fetchWeatherConditionsForNoidaOnCompletion:^(CityDataModel *cityWeatherInfo, NSString *returnedErrorString) {
        NSLog(@"Response recieved");
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [fetcActivityIndicator stopAnimating];
            
            if(cityWeatherInfo && !returnedErrorString) {
            
                arrayToPass = [NSArray arrayWithArray:[cityWeatherInfo futureConditions]];
                [self createSubview: cityWeatherInfo];
            }else {
            
                [self showError:returnedErrorString];
            }
        });
    }];
}

-(void) reFetch {
    
    [errorLabel setHidden:TRUE];
    [reloadButton setHidden:TRUE];
    errorLabel = nil;
    reloadButton = nil;
    [self startFetching];
}


-(void) showForecast {
    
    DetailedViewController *detailsVC = [[DetailedViewController alloc]initWithArray:arrayToPass];
    [self.navigationController pushViewController:detailsVC animated:TRUE];
    
}
@end
