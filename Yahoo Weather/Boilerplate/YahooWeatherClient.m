//
//  YahooWeatherClient.m
//  Boilerplate
//
//  Created by agatsa on 5/12/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "YahooWeatherClient.h"
#import "CityDataModel.h"
#import "CurrentCoditionsDataModel.h"
#import "ForecastConditionDataModel.h"




@implementation YahooWeatherClient

+(void) fetchWeatherConditionsForNoidaOnCompletion:(WeatherConditionsCompletionHandler) complete {
   
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSString * completePath = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20%3D%2090884333&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:completePath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            NSDictionary *responseDictionary = [[NSJSONSerialization JSONObjectWithData:data options:
                                                NSJSONReadingAllowFragments| NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:&error]valueForKeyPath:@"query.results.channel"];
            
            CityDataModel *cityData = [[CityDataModel alloc]init];
           
            [cityData setCityLatitude:[responseDictionary valueForKeyPath:@"item.lat"]];
            [cityData setCityLongitude:[responseDictionary valueForKeyPath:@"item.long"]];
            [cityData setCityName:[responseDictionary valueForKeyPath:@"location.city"]];
            [cityData setCityRegion:[responseDictionary valueForKeyPath:@"location.region"]];
            [cityData setCityCountry:[responseDictionary valueForKeyPath:@"location.country"]];
            
            CurrentCoditionsDataModel *currentConditions = [[CurrentCoditionsDataModel alloc]init];
            [currentConditions setCurrentConditionPublishDate:[responseDictionary valueForKeyPath:@"item.pubDate"]];
            [currentConditions setCurrentConditionSpeedUnit:[responseDictionary valueForKeyPath:@"units.speed"]];
            [currentConditions setCurrentConditionSunriseTime:[responseDictionary valueForKeyPath:@"astronomy.sunrise"]];
            [currentConditions setCurrentConditionSunsetTime:[responseDictionary valueForKeyPath:@"astronomy.sunset"]];
            [currentConditions setCurrentConditionTemperature:[responseDictionary valueForKeyPath:@"item.condition.temp"]];
            [currentConditions setCurrentConditionTempUnit:[responseDictionary valueForKeyPath:@"units.temperature"]];
            [currentConditions setCurrentConditionWeatherDescription:[responseDictionary valueForKeyPath:@"item.condition.text"]];
            [currentConditions setCurrentConditionWindSpeed:[responseDictionary valueForKeyPath:@"wind.speed"]];
            [currentConditions setCurrentConditionVisibility:[responseDictionary valueForKeyPath:@"atmosphere.visibility"]];
            [currentConditions setCurrentConditionHumidity:[responseDictionary valueForKeyPath:@"atmosphere.humidity"]];
            [currentConditions setCurrentConditionCode:[NSNumber numberWithInteger:[[responseDictionary valueForKeyPath:@"item.condition.code"]integerValue]]];
            [cityData setCurrentConditions:currentConditions];
            
            __block NSMutableArray *futureForecast = [NSMutableArray array];
           [[responseDictionary valueForKeyPath:@"item.forecast"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
               @autoreleasepool{
                   ForecastConditionDataModel *futureConditions = [[ForecastConditionDataModel alloc]init];
                   [futureConditions setForecastConditionCode:[NSNumber numberWithInteger:[[obj valueForKeyPath:@"code"]integerValue]]];
                   [futureConditions setForecastConditionDate:[obj valueForKeyPath:@"date"]];
                   [futureConditions setForecastConditionDay:[obj valueForKeyPath:@"day"]];
                   [futureConditions setForecastConditionDescription:[obj valueForKeyPath:@"text"]];
                   [futureConditions setForecastConditionTemperatureHigh:[obj valueForKeyPath:@"high"]];
                   [futureConditions setForecastConditionTemperatureLow:[obj valueForKeyPath:@"low"]];

                   [futureForecast addObject:futureConditions];
               }
           }];
            
            [cityData setFutureConditions:futureForecast];
             if(complete)
                complete(cityData,nil);
        }
        else {
            
            if(complete)
                complete(nil,[error localizedDescription]);
            
        }
        
    }];
    //start Task
    [task resume];

}

@end
