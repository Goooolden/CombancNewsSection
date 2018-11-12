//
//  NewInterfaceRequest.m
//  AFNetworking
//
//  Created by Golden on 2018/11/11.
//

#import "NewInterfaceRequest.h"
#import "NewsInterfaceMacro.h"
#import "NewsModel.h"
#import "HTTPTool.h"
#import "MJExtension.h"

@implementation NewInterfaceRequest

+ (void)requestNewsList:(NSDictionary *)param success:(RequestSucess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:GetNewslist_URL headers:header(MyToken) params:param success:^(id json) {
        switch ([json[@"result"] intValue]) {
            case 1:{
                //操作成功
                NSArray *dataArray = [NewslistModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
                success(dataArray);
                break;
            }
            case 0:{
                //没有查询到数据
                break;
            }
            case -1:{
                //操作过程中出现异常
                break;
            }
            case -2:{
                //数据重复，一般在新增接口中
                break;
            }
            case -100:{
                //用户会话过期，需重新登陆
                break;
            }
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
