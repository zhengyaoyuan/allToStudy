//
//  encode.h
//  KKBang
//
//  Created by mac on 13-10-24.
//
//

#define UP_USERID @"userId"
#define UP_PASSWORD @"password"

#import <Foundation/Foundation.h>

@interface HttpRequestEncoder : NSObject

+ (NSString*) encodeUserName:(NSString*)name andPassword:(NSString*)pwd;

+ (NSString*) encodeUuid:(NSString*)uuid;

+ (NSString*) encodeUnionid:(NSString*)unionid;

+ (NSString*) encodeNewPassword:(NSString*)newpwd;

+ (NSString*) encodeParamWithKey:(NSString*)param;

+ (NSDictionary*) decodeUDPD:(NSString*)udpd;

@end
