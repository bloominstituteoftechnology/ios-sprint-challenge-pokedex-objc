//
//  ARPokemon.m
//  PokedexObjc
//
//  Created by Alex Rhodes on 11/14/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

#import "ARPokedexPokemon.h"

@implementation ARPokedexPokemon

- (instancetype) initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    return [self initWithName:name url:url];
}

@end
