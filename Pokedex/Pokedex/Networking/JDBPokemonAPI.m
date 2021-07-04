//
//  JDBPokemonAPI.m
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import "JDBPokemonAPI.h"
#import "JDBPokemon.h"


@implementation JDBPokemonAPI

- (void)fetchPokemon:(PokemonCompletionHandler)completion {
    
    NSString *urlString = [NSString stringWithFormat:@"https://pokeapi.co/api/v2/pokemon/"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data,
                                                                                                       NSURLResponse * _Nullable response,
                                                                                                       NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching Pokemon:%@", error);
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            completion(nil, jsonError);
            return;
        }
        
        JDBPokemon *p = [[JDBPokemon alloc] initWithDictionary:json];
        completion(p, nil);
        
    }];
    [task resume];
    
}

@end
