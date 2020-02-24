//
//  Pokemon.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "Pokemon.h"

void *KVOPokeControllerContext = &KVOPokeControllerContext;

@implementation Pokemon

+ (instancetype)fromDictionary:(NSDictionary *)dictionary
{
    if (dictionary[@"name"] && dictionary[@"url"]) {
        NSURL *url = [NSURL URLWithString:(dictionary[@"url"])];
        int idNumber = [url.lastPathComponent intValue];
        Pokemon *newPokemon = [[Pokemon alloc] initWithName:dictionary[@"name"] pokemonID:idNumber];
        newPokemon.url = url;
        return newPokemon;
    }
    
    return nil;
}

- (instancetype)initWithName:(NSString *)name pokemonID:(int )idNumber
{
    if (self = [super init]) {
        _name = name;
        _pokemonID = idNumber;
    }
    
    [self addObserver:self forKeyPath:@"spriteURL" options:0 context:KVOPokeControllerContext];
    return self;
}

- (void)updateDetails
{
    // makes a network call to grab the image URL and the abilities list of the pokemon,
    // which then triggers a grab of the image from the URL
    
    if (self.spriteURL) return;     // quick check to see if this has already been done
    NSLog(@"Attempting to update details: %@", self.url);
    [[NSURLSession.sharedSession dataTaskWithURL:self.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Fetching %@", self.name);
        if (error) {
            NSLog(@"URLSession error: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"API response data is nil");
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Serialization Error: %@", jsonError);
            return;
        }
        
        NSArray *abilities = dictionary[@"abilities"];
        if (abilities) {
            NSMutableArray *abilitiesList = [[NSMutableArray alloc] init];
            for (NSDictionary *ability in abilities) {
                NSDictionary *abilityDetails = ability[@"ability"];
                [abilitiesList addObject:abilityDetails[@"name"]];
            }
            self.abilities = [abilitiesList copy];
        }
        
        NSDictionary *sprites = dictionary[@"sprites"];
        if (sprites) {
            if (sprites[@"front_default"]) {
                self.spriteURL = [NSURL URLWithString:(sprites[@"front_default"])];
            }
        }
    }] resume];
}

- (void)updateSprite
{
    [[NSURLSession.sharedSession dataTaskWithURL:self.spriteURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Fetching sprite for %@", self.name);
        if (error) {
            NSLog(@"URLSession error: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"API response data is nil");
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            self.sprite = image;
        }
    }] resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOPokeControllerContext) {
        if ([keyPath isEqualToString:@"spriteURL"]) {
            [self updateSprite];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
