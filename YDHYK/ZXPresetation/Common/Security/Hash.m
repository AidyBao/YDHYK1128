//
//  Hash.m
//
//  Created by mac on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Hash.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Hash


+(NSString *)Sha1Hash:(NSString *)source
{
    CC_MD5_CTX digestCtx;
    unsigned char digestBytes[CC_MD5_DIGEST_LENGTH];
    char digestChars[CC_MD5_DIGEST_LENGTH * 2 + 1];
    NSRange stringRange = NSMakeRange(0, [source length]);
    unsigned char buffer[128];
    NSUInteger usedBufferCount;
    CC_MD5_Init(&digestCtx);
    while ([source getBytes:buffer
                  maxLength:sizeof(buffer)
                 usedLength:&usedBufferCount
                   encoding:NSUnicodeStringEncoding
                    options:NSStringEncodingConversionAllowLossy
                      range:stringRange
             remainingRange:&stringRange])
        CC_MD5_Update(&digestCtx, buffer, usedBufferCount);
    CC_MD5_Final(digestBytes, &digestCtx);
    for (int i = 0;
         i < CC_MD5_DIGEST_LENGTH;
         i++)
        sprintf(&digestChars[2 * i], "%02x", digestBytes[i]);
    return [[NSString stringWithUTF8String:digestChars] uppercaseString];
}

+(NSString*)stringMD5:(NSString*)str
{
    if (str.length != 0) {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    }
    return nil;
}

+(NSString*)fileMD5:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [[NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1], 
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]] uppercaseString];
    [handle closeFile];
    return s;
}

+(NSString*)dataMD5:(NSData*)data
{
    
    if( [data length]<=0 ) return @"ERROR GETTING DATA MD5"; // file didnt exist
    
    return [Hash dataMD5:(Byte *)[data bytes] Length:[data length]];
    
}

+(NSString*)dataMD5:(Byte*)data Length:(int)len
{
    
    if( len<=0 ) return @"ERROR GETTING DATA MD5"; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    CC_MD5_Update(&md5, data, len);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [[NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1], 
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]] uppercaseString];
    return s;
}

@end
