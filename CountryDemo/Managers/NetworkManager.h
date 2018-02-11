//
//  NetworkManager.h
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

typedef NS_ENUM(NSInteger, CNNetworkMethodType) {
    CNNetworkMethodGET,
    CNNetworkMethodPOST
};

+ (void)connectionRequestWithMethod:(CNNetworkMethodType)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id JSON))success fail:(void (^)(NSError *error))fail;

@end
