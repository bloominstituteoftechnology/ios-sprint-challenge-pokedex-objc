//
//  SKSPokemon.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokemon.h"

@interface SKSPokemon()



@end

@implementation SKSPokemon


- (instancetype _Nonnull)initWithDictionary:(nonnull NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _detailsURL = dictionary[@"url"];
    }
    return self;
}



@end
