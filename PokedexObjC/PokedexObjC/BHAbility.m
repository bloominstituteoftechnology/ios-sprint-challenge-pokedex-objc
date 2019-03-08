//
//  BHAbility.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHAbility.h"

@implementation BHAbility

-(instancetype)initWithJSON:(id)json{
    if ([json isKindOfClass:[NSDictionary class]] == NO) { return nil;}
    
    self = [super init];
    if (self){
        BOOL hidden = [[json objectForKey:@"is_hidden"] boolValue];
        NSString *name = [json valueForKey:@"ability.name"];
        
        _hidden = hidden;
        _name = name;
    }
    return self;
}

@end
