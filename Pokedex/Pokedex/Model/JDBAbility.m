//
//  JDBAbility.m
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import "JDBAbility.h"

#define CheckClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }

@implementation JDBAbility

- (instancetype)initWithJSON:(id)json {
    CheckClass(json, NSDictionary);
    
    self = [super init];
    if (self) {
        BOOL hidden = [[json objectForKey:@"is_hidden"] boolValue];
        NSString *name = [json valueForKey:@"ability.name"];
        
        _hidden = hidden;
        _name = name;
        
    }
    return self;
    
}

@end
