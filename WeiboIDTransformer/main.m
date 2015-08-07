//
//  main.m
//  WeiboIDTransformer
//
//  Created by Bayonetta on 8/7/15.
//
//

#import <Foundation/Foundation.h>

@interface WeiboTransformer : NSObject

@end

@implementation WeiboTransformer

+ (NSString *)transfromURL:(NSString *)url {
    NSInteger code3 = [self string60To10:[url substringFromIndex:(url.length - 4)]];//倒数第三段，取4位，转10进制
    NSInteger code2 = [self string60To10:[url substringWithRange:NSMakeRange(url.length - 8, 4)]];//倒数第二段，取4位，转10进制
    NSInteger code1 = [self string60To10:[url substringWithRange:NSMakeRange(0, url.length - 8)]];//第一段，取剩下位数，转10进制
    
    return [[[@(code1) stringValue] stringByAppendingString:[self padLeftTolengthSeven:code2]] stringByAppendingString:[self padLeftTolengthSeven:code3]];//合并三段，返回
}

+ (NSInteger)string60To10:(NSString *)str62 {
    NSInteger i64 = 0;
    for (NSInteger i = 0; i < str62.length; i++) {
        NSInteger Vi = (NSInteger) pow(62, (str62.length - i - 1));
        i64 += Vi * [self string62Dictionary:[str62 substringWithRange:NSMakeRange(i, 1)]];
    }
    return i64;
}

+ (NSInteger)string62Dictionary:(NSString *)ks {
    NSArray *keys = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    NSInteger i = 0;
    for (NSString *k in keys) {
        if ([ks isEqualToString:[k substringWithRange:NSMakeRange(0, 1)]]) {
            return i;
        }
        i++;
    }
    return 0;
}

+ (NSString *)padLeftTolengthSeven:(NSInteger)code {
    NSString *result = [@(code) stringValue];
    if (result.length < 7) {
        result = [NSString stringWithFormat:@"%07ld", (long)code];
    }
    return result;
}

@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //从url获取
        //比如  http://weibo.com/2593883887/CtfizwohU?type=comment
        //" CtfizwohU "就是62进制的真实id
        
        NSLog(@"True Weibo ID: %@", [WeiboTransformer transfromURL:@"CtfizwohU"]);
    }
    return 0;
}
