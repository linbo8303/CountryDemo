//
//  NetworkManager.m
//  Country
//
//  Created by Bo Lin on 10/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (void)connectionRequestWithMethod:(CNNetworkMethodType)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id JSON))success fail:(void (^)(NSError *error))fail {
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    if (method == CNNetworkMethodPOST) {
        request.HTTPMethod = @"POST";
    }
    
    [request setValue:@"text/plain,text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    if (parameters != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = data;
    }

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ((data != nil) && (connectionError == nil)) {
            NSDictionary *jsonDict;
            if (![NSJSONSerialization isValidJSONObject:data]) {
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSISO2022JPStringEncoding];
                NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            } else {
                jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
            
            if (success) {
                success(jsonDict);
            }
        } else {
            if (fail) {
                fail(connectionError);
            }
        }
        
    }];
}

@end
