//
//  Pokemon.m
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

#import "Pokemon.h"


@interface Pokemon ()

@end

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (!self)
    { return nil; }
    
    _name = name;
    
    return self;
}

- (void)setAbilities:(NSArray<NSString *> *)abilities {
    _abilities = [abilities copy];
}
@end
