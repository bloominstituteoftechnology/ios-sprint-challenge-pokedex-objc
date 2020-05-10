//
//  OSIPokemonController.m
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import "OSIPokemonController.h"
#import "OSIPokemonName.h"
#import "OSIPokemon.h"

static NSString * const baseURL = @"https://pokeapi.co/api/v2/pokemon/?offset=1&limit=500";

@implementation OSIPokemonController

-(void)fetchPokemonName:(PokemonCompletionHandler)handler {
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching data: %@", error);
            handler(nil, error);
            return;
        }
        if (!data) {
            NSLog(@"Data is missing");
            handler(nil, [[NSError alloc] init]);
            return;
        }
        
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            handler(nil, jsonError);
            return;
        }
        
        OSIPokemonName *pokemon = [[OSIPokemonName alloc] initWithJSON:json];
        handler(pokemon, nil);
    }];
    
    [task resume];
    
}


- (void)fetchPokemonWithURL:(NSString *)pokemonURL complition:(PokemonDetailsCompletionHandler)complition {
    
    NSURL *url = [NSURL URLWithString:pokemonURL];
    
    //NSURL *url = pokemonURL;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching data: %@", error);
            complition(nil, error);
            return;
        }
        if (!data) {
            NSLog(@"Data is missing");
            complition(nil, [[NSError alloc] init]);
            return;
        }
        
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            complition(nil, jsonError);
            return;
        }
        
        OSIPokemon *pokemon = [[OSIPokemon alloc] initWithJSON:json];
        complition(pokemon, nil);
    }];
    
    [task resume];
    
}



@end
