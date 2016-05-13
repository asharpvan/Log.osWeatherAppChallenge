//
//  ForecastConditionDataModel.h
//  Boilerplate
//
//  Created by agatsa on 5/12/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastConditionDataModel : NSObject

@property (strong, nonatomic) NSNumber *forecastConditionCode;
@property (strong, nonatomic) NSString *forecastConditionDate;
@property (strong, nonatomic) NSString *forecastConditionTemperatureHigh;
@property (strong, nonatomic) NSString *forecastConditionTemperatureLow;
@property (strong, nonatomic) NSString *forecastConditionDescription;
@property (strong, nonatomic) NSString *forecastConditionDay;

@end
