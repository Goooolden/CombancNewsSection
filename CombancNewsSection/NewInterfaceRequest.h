//
//  NewInterfaceRequest.h
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSucess)(id json);
typedef void(^RequestFailed)(NSError *error);

@interface NewInterfaceRequest : NSObject

+ (void)requestNewsList:(NSDictionary *)param success:(RequestSucess)success failed:(RequestFailed)failed;

@end
