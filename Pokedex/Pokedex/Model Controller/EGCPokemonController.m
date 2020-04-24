//
//  EGCPokemonController.m
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCPokemonController.h"

@interface EGCPokemonController ()

@property (nonatomic, readonly) NSURL *baseURL;

@end

@implementation EGCPokemonController

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://pokeapi.co/api/v2/pokemon/"];
    }
    return self;
}

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<EGCPokemon *> * _Nullable, NSError * _Nullable))completion {
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:self.baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Nil Data");
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
            EGCPokemon *pokemon = [[EGCPokemon alloc] initWithDictionary:result];
            [pokemons addObject:pokemon];
        }
        
        completion(pokemons, nil);
    }];
    [task resume];
}

- (void)fillInDetails:(EGCPokemon *)pokemon {
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:pokemon.name];

    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (data == nil) {
            NSLog(@"Nil Data");
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (jsonError) {
            return;
        }
        
        EGCPokemon *pokemon = [[EGCPokemon alloc] initWithDictionary:jsonData];
        self.pokemon = pokemon;
    }];
    [task resume];
}

@end
