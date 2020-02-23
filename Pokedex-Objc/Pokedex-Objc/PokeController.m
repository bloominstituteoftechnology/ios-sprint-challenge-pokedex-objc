//
//  PokeController.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "PokeController.h"
#import "Pokemon.h"
#import <UIKit/UIKit.h>

@interface PokeController ()

@property NSURL *baseURL;
@property NSMutableArray *internalPokemonList;

@end

@implementation PokeController

#pragma mark - Initializers

- (instancetype)init
{
    if (self = [super init]) {
        _baseURL = [NSURL URLWithString:@"https://pokeapi.co/api/v2/"];
    }
    
    [self catchEmAll:^(NSArray *pokemonList, NSError *error) {
        if (pokemonList) {
            NSLog(@"Pokemon list retrieved");
        }
    }];
    
    return self;
}


#pragma mark - API access

- (void)catchEmAll:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion
{
    NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"limit" value:@"1000"];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[_baseURL URLByAppendingPathComponent:@"pokemon"] resolvingAgainstBaseURL:NO];
    components.queryItems = @[queryItem];
    NSURL *url = components.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Catch 'em all! URL: %@", url);
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : @"API response data is nil" };
            NSError *dataError = [NSError errorWithDomain:@"PokedexCatchEmAll" code:1 userInfo:userInfo];
            completion(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON Serialization Error: %@", jsonError);
            completion(nil, jsonError);
            return;
        }
        
        NSArray *results = dictionary[@"results"];
        if (results) {
            NSMutableArray *pokemonList = [[NSMutableArray alloc] init];
            for (NSDictionary *result in results) {
                Pokemon *pokemon = [Pokemon fromDictionary:result];
                if (pokemon) {
                    [pokemonList addObject:pokemon];
                } else {
                    NSLog(@"Nil pokemon for result: %@", result);
                }
            }
            self->_internalPokemonList = pokemonList;
            completion(pokemonList, nil);
        }
        
        completion(nil, [NSError errorWithDomain:@"PokedexCatchEmAll" code:2 userInfo:@{ NSLocalizedDescriptionKey : @"No pokemon decoded" }]);
    }] resume];
    
}

- (void)fetchPokemonByName:(NSString *)name withCompletion:(void (^)(Pokemon *))completion
{
    
}

- (void)fetchPokemonByID:(int)idNumber withCompletion:(void (^)(Pokemon *))completion
{
    
}

- (void)getImageForPokemon:(Pokemon *)pokemon withCompletion:(void (^)(UIImage *))completion
{
    
}

#pragma mark - Accessors

- (NSArray *)getPokemonList
{
    return [_internalPokemonList copy];
}

@end
