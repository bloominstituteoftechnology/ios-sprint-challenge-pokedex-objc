//
//  KMLPokemonController.m
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import "KMLPokemonController.h"

@interface KMLPokemonController ()

@property (nonatomic, readonly) NSURL *baseURL;

@end

@implementation KMLPokemonController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://pokeapi.co/api/v2/pokemon/"];
    }
    return self;
}

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<KMLPokemon *> * _Nullable, NSError * _Nullable))completion
{
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:self.baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data was nil");
            completion(nil, [[NSError alloc] init]);
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError) {
            completion(nil, error);
            return;
        }
        
        NSArray *results = jsonData[@"results"];
        NSMutableArray *pokemons = [[NSMutableArray alloc] init];
        
        for (NSDictionary *result in results) {
            KMLPokemon *pokemon = [[KMLPokemon alloc] initWithDictionary:result];
            [pokemons addObject:pokemon];
        }
        
        completion(pokemons, nil);
    }];
    [task resume];
}

- (void)fillInDetails:(KMLPokemon *)pokemon
{
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:pokemon.name];

    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data was nil");
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError) {
            return;
        }
        
        KMLPokemon *pokemon = [[KMLPokemon alloc] initWithDictionary:jsonData];
        self.pokemon = pokemon;
    }];
    [task resume];
}


@end
