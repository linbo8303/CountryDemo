//
//  MTLCountryContent.h
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLCountryContent : MTLModel <MTLJSONSerializing>

@property (readonly, nonatomic, copy) NSString *title;
@property (readonly, nonatomic, copy) NSString *descr;
@property (readonly, nonatomic, copy) NSString *imageHref;

@end
