//
//  Pokemon.m
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "Pokemon.h"

@interface Pokemon ()


@end

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
     if (!self) { return nil; }
     
     _name = name;
     
     return self;
}

@end
