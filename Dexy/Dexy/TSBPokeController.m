//
//  TSBPokeController.m
//  Dexy
//
//  Created by Thomas Sabino-Benowitz on 7/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "TSBPokeController.h"

@interface TSBPokeController ()

@property (nonatomic, readonly) NSURL *baseURL;

@end

@implementation TSBPokeController

- (instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = [[NSURL alloc] initWithString:@"https://pokeapi.co/api/v2/pokemon/"];
    }
    return self;
}

- (void)fetchAllPokemonCompletion:(void (^)(NSArray<TSBPokemon *> * _Nullable, NSError * _Nullable))completion {
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
            TSBPokemon *pokemon = [[TSBPokemon alloc] initWithDictionary:result];
            [pokemons addObject:pokemon];
        }
        
        completion(pokemons, nil);
    }];
    [task resume];
}

- (void)addJsonDetails:(TSBPokemon *)pokemon {
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
        
        TSBPokemon *pokemon = [[TSBPokemon alloc] initWithDictionary:jsonData];
        self.pokemon = pokemon;
    }];
    [task resume];
}

@end

