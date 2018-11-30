//
//  DYPPokemon.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemon.h"

@implementation DYPPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSString *)abilities sprite:(NSURL *)sprite
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = [identifier copy];
        _abilities = [abilities copy];
        _sprite = [sprite copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    
    if (identifier) {
        
        NSArray *abilitiesArray = dictionary[@"abilities"];
        NSMutableString *abilities = [NSMutableString string];
        
        for (NSDictionary *dictionary in abilitiesArray) {
            NSDictionary *abilityDictionary = dictionary[@"ability"];
            NSString *abilityName = abilityDictionary[@"name"];
            [abilities appendString:[NSString stringWithFormat:@"%@,", abilityName]];
        }
        
        NSDictionary *spritesDictionary = dictionary[@"sprites"];
        
        NSString *spriteURLString = spritesDictionary[@"front_default"];
        NSURL *spriteURL = [NSURL URLWithString:spriteURLString];
//        __block UIImage *spriteImage;
//        @synchronized (spriteImage) {
//            [self imageFromURL:spriteURL completionBlock:^(UIImage *image, NSError *error) {
//                spriteImage = image;
//            }];
//        }
        
        return [self initWithName:name identifier:identifier abilities:abilities sprite:spriteURL];
    }
    
    return [self initWithName:name identifier:NULL abilities:NULL sprite:NULL];
}

@end
