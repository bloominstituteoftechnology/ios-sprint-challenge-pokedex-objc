//
//  JCSPokemonController.m
//  PokePracticeObjC
//
//  Created by Lambda_School_Loaner_95 on 4/11/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSPokemonController.h"
#import "JCSPokemon.h"

static NSString *baseURLString = @"https://pokeapi.co/api/v2/pokemon/";

@interface JCSPokemonController ()

@property (nonatomic, copy) NSMutableArray<JCSPokemon *> *internalPokemon;

@end

@implementation JCSPokemonController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPokemon = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchAllPokemon:(JCSPokemonControllerCompletionBlock)completion {
//- (void)fetchPokemonByName:(NSString *)name completion:(void (^)(NSError *))completion {
    
    
   // NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
   // NSURL *pokemonURL = [baseURL URLByAppendingPathComponent: name.lowercaseString];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching pokemon: %@", error);
            completion(nil, error);
            return;
        }
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding: %@", error);
            completion(nil, error);
            return;
        }
        
        NSArray *resultsArray = dictionary[@"results"];
        
        NSMutableArray *pokemons = [[NSMutableArray alloc] init];
       /* JCSPokemon *pokemon = [[JCSPokemon alloc] initWithDictionary:dictionary];
        [pokemons addObject:pokemon];*/
        
        for (NSDictionary *dict in resultsArray) {
            NSURL *pokeURL = dict[@"url"];
            NSString *pokeName = dict[@"name"];
            JCSPokemon *pokemon = [[JCSPokemon alloc] initWithURL:pokeURL name:pokeName];
            [pokemons addObject:pokemon];
        }
        self.internalPokemon = pokemons;
        NSLog(@"Pokemon from all fetch: %@", self.internalPokemon);
        completion(pokemons, nil);
        
    }];
    [task resume];
    
}

- (void)fillInDetails:(JCSPokemon *)pokemon {
    
    NSURL *pokemonURL = [NSURL URLWithString:pokemon.pokemonURL];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:pokemonURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching pokemon: %@", error);
            //completion(error);
            return;
        }
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding: %@", error);
           // completion(error);
            return;
        }
        
        
        NSMutableArray *pokemons = [[NSMutableArray alloc] init];
        JCSPokemon *pokemonWithDetails = [[JCSPokemon alloc] initWithDictionary:dictionary];
        
        [pokemon setValue:pokemonWithDetails.name forKey:@"name"];
        [pokemon setValue:pokemonWithDetails.abilities forKey:@"abilities"];
        [pokemon setValue:pokemonWithDetails.photoURL forKey:@"photoURL"];
        NSNumber *idValue = [NSNumber numberWithInteger:pokemonWithDetails.identifier];
        [pokemon setValue:idValue forKey:@"identifier"];
        
       // [pokemons addObject:pokemon];
        if (pokemon.name && pokemon.abilities && pokemon.identifier && pokemon.photoURL) {
            NSNumber *boolValue = [NSNumber numberWithBool:YES];
            [pokemon setValue:boolValue forKey:@"isFilled"];
            NSLog(@"Pokemon from fetch detail has been set: %@", pokemonWithDetails.name);
        }
        //self.internalPokemon = pokemons;
        
       // completion(nil);
        
    }];
    [task resume];
}

- (NSArray<JCSPokemon *> *)pokemons {
    return self.internalPokemon;
}

@end
