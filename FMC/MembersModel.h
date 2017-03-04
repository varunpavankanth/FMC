//
//  MembersModel.h
//  FMC
//
//  Created by Nennu on 26/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MembersModel : NSObject
@property (nonatomic) NSString * first_name;
@property (nonatomic) NSString * last_name;
@property (nonatomic) NSString * company_name;
@property (nonatomic) NSString * profile_pic;

- (instancetype) initWithDictionary : (NSDictionary *) dictionary;
@end
