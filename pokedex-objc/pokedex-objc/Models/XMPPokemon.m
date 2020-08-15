//
//  XMPPokemon.m
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import "XMPPokemon.h"

@implementation XMPPokemon

-(instancetype)initWithName:(NSString*)name url:(NSString*)url {
    if(self = [super init]) {
        _name = name;
        _url = url;
    }
    return self;
}

@end
