//
//  APIService.m
//  ISSPosition
//
//  Created by Shashi Chunara on 10/08/22.
//

#import "APIService.h"

@implementation APIService

-(NSString *)baseURL {
    return @"http://api.open-notify.org/iss-now.json";
}

+(APIService *)shared{
    
    static APIService *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

-(void)getLocationWithCompletion:(void (^)(NSDictionary *response))success failure:(void (^)(NSError *error))failure {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:self.baseURL]];
    [request setHTTPMethod:@"GET"];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // JSON Parsing Error
                    failure(jsonError);
                } else {
                    // JSON Parsing Success
                    // Log NSDictionary response:
                    
                    success(jsonResponse);
                }
            }  else {
                // Got an error from server
            }
        } else {
            // web service failed
            failure(error);
        }
        
    }] resume];
}
@end
