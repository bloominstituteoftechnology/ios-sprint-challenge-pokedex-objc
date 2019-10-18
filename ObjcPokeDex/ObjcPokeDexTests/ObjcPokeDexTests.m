//
//  ObjcPokeDexTests.m
//  ObjcPokeDexTests
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIPokemon.h"
#import "LSIFileHelper.h"

@interface ObjcPokeDexTests : XCTestCase

@end

@implementation ObjcPokeDexTests

- (void)testParseJSONForTableView {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSData *data = loadFile(@"PokeNameAndURL.json",bundle);
    XCTAssertNotNil(data);
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
    NSMutableArray *resultsArray = json[@"results"];
    NSMutableArray *allPokemons = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *values in resultsArray) {
        LSIPokemon *pokemonNameAndURL = [[LSIPokemon alloc] initDictionaryToGetNameAndURL:values];
        [allPokemons addObject:pokemonNameAndURL];
    }
    
    XCTAssertEqual(20, allPokemons.count);
}

- (void)testParseJSONToFillInPokemonDetails {
    
}


@end
