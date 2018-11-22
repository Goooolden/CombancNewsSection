//
//  NewsInterfaceMacro.h
//  Pods
//
//  Created by Golden on 2018/11/11.
//

#import <UIKit/UIKit.h>
#ifndef NewsInterfaceMacro_h
#define NewsInterfaceMacro_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
[dictionary setObject:object forKey:@#object]; \
} while (0)

#define setObjectForParameter(object) \
do { \
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil]; \
NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; \
[paramDic setObject:str forKey:@"param"]; \
} while (0)

#define NewsToken (@"token")
#define NewsBaseUrl (@"NewsBaseUrl")
#define NewsImageURL ([NSString stringWithFormat:@"%@/file/upload",[[NSUserDefaults standardUserDefaults] objectForKey:NewsBaseUrl]])
#define BASE_URL ([NSString stringWithFormat:@"%@/oa",[[NSUserDefaults standardUserDefaults] objectForKey:NewsBaseUrl]])
#define MyToken [[NSUserDefaults standardUserDefaults] objectForKey:NewsToken]

//请求header
NS_INLINE NSDictionary *header(NSString *token) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(token);
    return dictionary;
}

//获取新闻列表
#define GetNewslist_URL ([NSString stringWithFormat:@"%@/news/list",BASE_URL])
/**
 获取新闻列表的参数
 @param page 当前页
 @param pageSize 每页条数
 @param sdate 开始时间
 @param edate 结束时间
 @param types news-type
 @param searchStr 搜索内容
 */
NS_INLINE NSDictionary *newslistParam(NSString *page,NSString *pageSize,NSString *sdate,NSString *edate,NSString *types,NSString *searchStr) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(page);
    setObjectForKey(pageSize);
    setObjectForKey(sdate);
    setObjectForKey(edate);
    setObjectForKey(types);
    setObjectForKey(searchStr);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//获取新闻详情（返回参数与新闻列表一样，不需要再次请求）
#define GetNewsinfo_URL ([NSString stringWithFormat:@"%@/news/info",BASE_URL])
/**
 获取新闻详情参数
 @param id 新闻ID
 */
NS_INLINE NSDictionary *newsInfoParam(NSString *id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(id);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

#endif /* NewsInterfaceMacro_h */
