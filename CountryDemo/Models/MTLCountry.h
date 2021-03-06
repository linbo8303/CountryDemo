//
//  MTLCountry.h
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface MTLCountry : MTLModel <MTLJSONSerializing>

@property (readonly, nonatomic, copy) NSString *title;
@property (readonly, nonatomic, copy) NSArray *contents;

@end
