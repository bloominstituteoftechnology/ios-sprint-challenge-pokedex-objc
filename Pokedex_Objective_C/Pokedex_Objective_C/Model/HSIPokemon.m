//
//  HSIPokemon.m
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

#import "HSIPokemon.h"

@implementation HSIPokemon

-(instancetype) initWithName:(NSString *)name url:(NSURL *)url {
    {
        self = [super init];
        if (self) {
            _name = [name copy];
            _url = [url copy];
            _abilities = [NSMutableArray<NSString *> new];
        }
        return self;
    }
}


@end
