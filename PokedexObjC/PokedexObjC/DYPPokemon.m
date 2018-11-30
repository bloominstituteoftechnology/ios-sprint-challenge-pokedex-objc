//
//  DYPPokemon.m
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPPokemon.h"

@implementation DYPPokemon

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *)identifier abilities:(NSString *)abilities sprite:(UIImage *)sprite
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
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    if (abilitiesArray) {
        NSMutableString *abilities = [NSMutableString string];
        
        for (NSDictionary *dictionary in abilitiesArray) {
            NSDictionary *abilityDictionary = dictionary[@"ability"];
            NSString *abilityName = abilityDictionary[@"name"];
            [abilities appendString:[NSString stringWithFormat:@"%@,", abilityName]];
        }
        
        NSDictionary *spritesDictionary = dictionary[@"sprites"];
        
        NSString *spriteURLString = spritesDictionary[@"front_default"];
        NSURL *spriteURL = [NSURL URLWithString:spriteURLString];
        UIImage *spriteImage = [self imageFromURL:spriteURL];
        
        return [self initWithName:name identifier:identifier abilities:abilities sprite:spriteImage];
    }
    
    return [self initWithName:name identifier:identifier abilities:NULL sprite:NULL];
}

- (UIImage *)imageFromURL:(NSURL *)url
{
    __block UIImage *image;
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching image from URL: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            return;
        }
        
        image = [UIImage imageWithData:data];
        
    }] resume];
    
    return image;
}

@end
