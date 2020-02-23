//
//  VVSPokemonController.m
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPokemonController.h"

@interface VVSPokemonController ()

@property (nonatomic, readonly) NSURL *baseURL;

@end

@implementation VVSPokemonController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://pokeapi.co/api/v2/pokemon/"];
    }
    return self;
}

- (void)fetchAllPokemonsCompletion:(void (^)(NSArray<VVSPokemon *> * _Nullable, NSError * _Nullable))completion
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
            VVSPokemon *pokemon = [[VVSPokemon alloc] initWithDictionary:result];
            [pokemons addObject:pokemon];
        }
        
        completion(pokemons, nil);
    }];
    [task resume];
}

- (void)fetchPokemonWithName:(NSString *)name completion:(void (^)(VVSPokemon * _Nullable, NSError * _Nullable))completion
{
    
    NSURL *url = self.baseURL;
    url = [url URLByAppendingPathComponent:name];

    // URL Request
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
        
        VVSPokemon *pokemon = [[VVSPokemon alloc] initWithDictionary:jsonData];
        
        completion(pokemon, nil);
    }];
    [task resume];
}

@end
