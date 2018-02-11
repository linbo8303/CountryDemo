//
//  MTLCountry.m
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import "MTLCountry.h"
#import "MTLCountryContent.h"

@implementation MTLCountry

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"title",
             @"contents": @"rows",
             };
}

+ (NSValueTransformer *)contentsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MTLCountryContent class]];
}


@end
