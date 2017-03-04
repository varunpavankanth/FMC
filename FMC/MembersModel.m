//
//  MembersModel.m
//  FMC
//
//  Created by Nennu on 26/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "MembersModel.h"

@implementation MembersModel

- (instancetype) initWithDictionary : (NSDictionary *) dictionary
{
    self = [super init];
    
    if (self)
    {
        _first_name = [dictionary valueForKey:@"first_name"];
        _last_name = [dictionary valueForKey:@"last_name"];
        _company_name = [dictionary valueForKey:@"company_name"];
         _profile_pic = [dictionary valueForKey:@"profile_pic"];
    }
    
    return self;
}

@end
