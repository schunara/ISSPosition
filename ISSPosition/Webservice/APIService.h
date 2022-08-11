//
//  APIService.h
//  ISSPosition
//
//  Created by Shashi Chunara on 10/08/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIService : NSObject

+(APIService *)shared;
-(void)getLocationWithCompletion:(void (^)(NSDictionary *response))completion failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
