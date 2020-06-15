//
//  CKPokemon.m
//  PokeDex-ObjC
//
//  Created by Christy Hicks on 6/14/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

#import "CKPokemon.h"

@implementation CKPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    
    return self;
}

@end
