//
//  CityDataModel.h
//  Boilerplate
//
//  Created by agatsa on 5/12/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CurrentCoditionsDataModel;

@interface CityDataModel : NSObject

@property (strong, nonatomic) NSString *cityLongitude;
@property (strong, nonatomic) NSString *cityLatitude;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *cityRegion;
@property (strong, nonatomic) NSString *cityCountry;
@property (strong, nonatomic) CurrentCoditionsDataModel *currentConditions;
@property (strong, nonatomic) NSMutableArray *futureConditions;


@end
