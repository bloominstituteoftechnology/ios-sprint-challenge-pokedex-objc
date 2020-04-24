//
//  NPTPokemon.m
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import "NPTPokemon.h"

@implementation NPTPokemon
- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    if (!name) { return nil; }
    return [self initWithName:name];
    
}
@end
