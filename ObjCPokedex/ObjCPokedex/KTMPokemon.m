//
//  KTMPokemon.m
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

#import "KTMPokemon.h"

@implementation KTMPokemon


- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                      spriteURL:(NSURL *)spriteURL
                   abilities:(NSArray *)abilities {
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _spriteURL = [spriteURL copy];
        _abilities = [abilities copy];
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    
    NSURL *spriteURL = [dictionary valueForKeyPath:@"sprites.front_default"];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSArray *abilities = [abilitiesArray valueForKeyPath:@"ability.name"];
    
    
    return [self initWithName:name identifier:identifier spriteURL:spriteURL abilities:abilities];
}





@end
