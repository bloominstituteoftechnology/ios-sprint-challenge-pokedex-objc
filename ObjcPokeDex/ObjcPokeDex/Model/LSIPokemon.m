//
//  LSIPokemon.m
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

-(instancetype)initDictionaryToGetNameAndURL:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *pokeInfoURL = dictionary[@"url"];
    return [self initWithName:name pokeID: NULL pokeInforURL:pokeInfoURL pokeAbilities: NULL andSprites: NULL];
}

@end
