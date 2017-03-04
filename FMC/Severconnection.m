//
//  Severconnection.m
//  FMC
//
//  Created by Nennu on 08/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Severconnection.h"
#import "UIView+Toast.h"
@implementation Severconnection
@synthesize dic;
-(id)init
{
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return self;
}
-(void)SeverLogIn:(NSString *)userName password:(NSString *)password
{
    NSString * mystring =[NSString stringWithFormat:@"username=%@&password=%@",userName,password];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/login"]];
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    dic=[[NSDictionary alloc]init];
    [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"%@",request);
        NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
        dic=nil;
        [dataTask resume];
//    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                     {
//                                           dispatch_async(dispatch_get_main_queue(), ^{
//                                       json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                               dic=json;
//
//                                           });
//                                     }];
//    [dataTask resume];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data1
{
    
    id json = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
    
    if(dic == nil)
    {
        dic=json;
    }
    else
    {
        dic = [dic initWithDictionary:json];
    }
     dispatch_async(dispatch_get_main_queue(), ^{[self downloadata];});
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
    error1=error;
  //  dispatch_async(dispatch_get_main_queue(), ^{[self downloadata];});
    
}
-(NSDictionary *)downloadata
{
    NSLog(@"%@",dic);
    return [dic copy];
}

@end
