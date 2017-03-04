//
//  APIDataFetcher.m
//
//  Created by Nirav Bhatt on 9/5/15.
//  Copyright (c) 2015 IphoneGameZone. All rights reserved.
/* Generic JSON fetch routines through NSURLConnection
 Part of: https://github.com/vividcode/iOSAPIDataApp/tree/master/iOSAPIDataApp
 */

#import "APIDataFetcher.h"

static NSOperationQueue * _connectionQueue = nil;
static NSURLSession * _session = nil;

@implementation APIDataFetcher

+ (NSOperationQueue *) connectionQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_connectionQueue)
        {
            _connectionQueue = [[NSOperationQueue alloc] init];
        }
    });
    return _connectionQueue;
}

+ (void) createURLSession
{
    static dispatch_once_t onceToken;
    
    if (!_session)
    {
        dispatch_once(&onceToken, ^{
            _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        });
    }
}

+ (void) loadDataFromAPIUsingSession : (NSString *) url : (SuccessBlock) successBlock :(FailureBlock) failureBlock
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self createURLSession];
    
    NSURLSessionDataTask * task = [_session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (response != nil)
        {
            if ([[self acceptableStatusCodes] containsIndex:[(NSHTTPURLResponse *)response statusCode]])
            {
                if ([data length] > 0)
                {
                    NSError *jsonError  = nil;
                    id jsonObject  = nil;
                    
                    jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    
                    if (jsonObject != nil)
                    {
                        [self presentData:jsonObject :successBlock];
                    }
                    else
                    {
                        [self presentError:jsonError :failureBlock];
                    }
                }
                else
                {
                    [self presentError:nil :failureBlock];
                }
            }
            else
            {
                [self presentError:nil :failureBlock];
            }
        }
        else
        {
            [self presentError:error :failureBlock];
        }
    }];
    
    [task resume];
}

+ (void) loadDataFromAPI : (NSString *) url : (SuccessBlock) successBlock :(FailureBlock) failureBlock
{
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[self connectionQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (response != nil)
         {
             if ([[self acceptableStatusCodes] containsIndex:[(NSHTTPURLResponse *)response statusCode] ])
             {
                 if ([data length] > 0)
                 {
                     NSError *jsonError  = nil;
                     id jsonObject  = nil;
                     
                     jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                     
                     if (jsonObject != nil)
                     {
                         [self presentData:jsonObject :successBlock];
                     }
                     else
                     {
                         [self presentError:jsonError :failureBlock];
                     }
                 }
                 else
                 {
                     [self presentError:nil :failureBlock];
                 }
             }
             else
             {
                 [self presentError:nil :failureBlock];
             }
         }
         else
         {
             [self presentError:connectionError :failureBlock];
         }
     }];
}

+ (NSIndexSet *) acceptableStatusCodes
{
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)];
}

+ (void) presentData:(id)jsonObject :(SuccessBlock) block
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:
     ^{
         block(jsonObject);
     }];
}

+ (void) presentError:(NSError *)error :(FailureBlock) block
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:
     ^{
         block(error);
     }];
}
@end
