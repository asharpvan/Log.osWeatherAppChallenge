//
//  CurrentCoditionsDataModel.h
//  Boilerplate
//
//  Created by agatsa on 5/12/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentCoditionsDataModel : NSObject

@property (strong, nonatomic) NSString *currentConditionPublishDate;
@property (strong, nonatomic) NSString *currentConditionTempUnit;
@property (strong, nonatomic) NSString *currentConditionSpeedUnit;
@property (strong, nonatomic) NSString *currentConditionWindSpeed;
@property (strong, nonatomic) NSString *currentConditionHumidity;
@property (strong, nonatomic) NSString *currentConditionVisibility;
@property (strong, nonatomic) NSString *currentConditionTemperature;
@property (strong, nonatomic) NSString *currentConditionWeatherDescription;
@property (strong, nonatomic) NSString *currentConditionSunriseTime;
@property (strong, nonatomic) NSString *currentConditionSunsetTime;
@property (strong, nonatomic) NSNumber *currentConditionCode;
@end
