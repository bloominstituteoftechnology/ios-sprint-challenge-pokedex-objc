//
//  Pokemon.m
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithDict:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        _name = dictionary[@"name"];
        _url = dictionary[@"url"];
        _identifier = dictionary[@"id"];
        _type = dictionary[@"type"];
        _abilities = dictionary[@"abilities"];
        _sprite = dictionary[@"sprites"];
    }
    
    return self;
}

@end
