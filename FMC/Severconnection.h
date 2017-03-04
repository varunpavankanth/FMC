//
//  Severconnection.h
//  FMC
//
//  Created by Nennu on 08/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol Severconnectiondelegate <NSObject>
-(NSDictionary *)downloadata;


@end
@interface Severconnection : NSObject<NSURLSessionDelegate>
{
   // id json;
  //  NSDictionary *dic;
    NSError *error1;
}

-(void)SeverLogIn:(NSString *)userName password:(NSString *)password;
@property (nonatomic) id<Severconnectiondelegate> delegate;
@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong)NSDictionary *dic;
//@property (nonatomic,strong) id json;
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@end
