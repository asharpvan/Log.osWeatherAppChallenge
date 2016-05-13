//
//  YahooWeatherClient.h
//  Boilerplate
//
//  Created by agatsa on 5/12/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityDataModel;

typedef void(^WeatherConditionsCompletionHandler)(CityDataModel *, NSString *);

@interface YahooWeatherClient : NSObject

+(void) fetchWeatherConditionsForNoidaOnCompletion:(WeatherConditionsCompletionHandler) complete;

@end
