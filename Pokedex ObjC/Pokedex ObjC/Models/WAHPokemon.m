//
//  WAHPokemon.m
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WAHPokemon.h"

@implementation WAHPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    return self;
}

@end
