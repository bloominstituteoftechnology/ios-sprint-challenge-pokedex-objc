////
////  ALWPokemonAPI.m
////  Pokedex ObjC Sprint Challenge
////
////  Created by Audrey Welch on 3/15/19.
////  Copyright © 2019 Audrey Welch. All rights reserved.
////
//
//#import "ALWPokemonAPI.h"
//#import "ALWPokemon.h"
//
//@interface ALWPokemonAPI ()
//
//@property NSString *baseURLString;
//
//@end
//
//@implementation ALWPokemonAPI
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        _allPokemon = [NSArray arrayWithObjects: nil];
//        _baseURLString = @"https://pokeapi.co/api/v2/pokemon";
//    }
//    return self;
//}
//
////- (void)fetchAllPokemonObjc:(void (^)(NSArray *allPokemon, NSError *error))completion {
//
//- (void)fetchPokemonDetailsWithPokemon:(ALWPokemon *)pokemon completion:(void (^)(ALWPokemon *pokemon, NSError *error))completion; {
//
//    // Create a URL
//    NSURL *baseURL = [NSURL URLWithString:_baseURLString];
//
//    NSURL *requestURL = [baseURL URLByAppendingPathComponent:(@"%@", pokemon.name.lowercaseString)];
//
//    NSLog(@"%@", requestURL);
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
//
//    // Create data task
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *r, NSError *error) {
//
//        if (error != nil) {
//            NSLog(@"Error fetching data %@", error);
//            completion(nil, error);
//        }
//
//        // Take data and turn it into a JSON object (a dictionary)
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//
//        // top level is dictionary
//        // Check to make sure it's a dictionary and not an array
//        if (![dictionary isKindOfClass:[NSDictionary class]]) {
//            NSLog(@"JSON was not a dictionary");
//            completion(nil, error);
//            return;
//        }
//
//        // name: "bulbasaur"
//        // If it is a dictionary, first pull out the name
//        ALWPokemon *pokemon = [[ALWPokemon alloc] init];
//        pokemon.name = [dictionary objectForKey:@"name"];
//
//        // id: 1
//        pokemon.pokemonID = [dictionary objectForKey:@"id"];
//
//        // sprites {}
//        // front_default: "url"
//        // Get out the "sprites" key
//        NSDictionary *spritesDictionary = [dictionary objectForKey:@"sprites"];
//        // Make sure it is a dictionary
//        if ([spritesDictionary isKindOfClass:[NSDictionary class]] == NO) {
//            NSLog(@"JSON does not have a 'sprites' dictionary");
//            completion(nil, nil);
//            return;
//        }
//
//        pokemon.sprite = [spritesDictionary objectForKey:@"front_default"];
//
//        // abilities: []
//        // {}
//        // ability: {}
//        // name
//
//
//
//    }] resume];
//}
//
//@end
