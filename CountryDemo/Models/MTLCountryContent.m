//
//  MTLCountryContent.m
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import "MTLCountryContent.h"

@implementation MTLCountryContent

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"descr": @"description",
             @"imageHref": @"imageHref",
             };
}



@end
