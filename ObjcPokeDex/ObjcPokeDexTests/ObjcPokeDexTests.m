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
    
    LSIPokemon *pokemon = [[LSIPokemon alloc] initWithName:@"bulbasaur" pokeID:NULL pokeInforURL:@"https://pokeapi.co/api/v2/pokemon/1/" pokeAbilities:NULL andSprites:NULL];
     NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSData *infoData = loadFile(@"PokeInfo.json",bundle);
    XCTAssertNotNil(infoData);
     NSError *error = nil;
    NSDictionary *jsonForPokeInfo = [NSJSONSerialization JSONObjectWithData:infoData options:0 error: &error];
    
    //parse the abilities and set them
    NSMutableArray *abilities = jsonForPokeInfo[@"abilities"];
    pokemon.abilites = [[NSMutableArray<NSString *> alloc] init];
    for (NSMutableDictionary *ability in abilities) {
        NSMutableDictionary *innerAbility = [ability valueForKey:@"ability"];
        NSString *abilityString = [innerAbility valueForKey:@"name"];
        NSString *abilityName = [[NSString alloc] initWithString:abilityString];
        [pokemon.abilites addObject:abilityName];
    }
    XCTAssertEqual(2 , pokemon.abilites.count);
    
    //parse the ID and set it
    pokemon.ID = [[NSNumber alloc] initWithInt: [[jsonForPokeInfo valueForKey:@"id"]intValue]];
    XCTAssertTrue(pokemon.ID > 0);
    
    //parse the sprite url string and set it
    NSMutableDictionary *spriteDict = [jsonForPokeInfo valueForKey:@"sprites"];
    NSString *receivedSpriteURLString = [spriteDict valueForKey:@"front_shiny"];
    pokemon.spriteURLString = [[NSString alloc] initWithString:receivedSpriteURLString];
    XCTAssertEqualObjects(@"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png", pokemon.spriteURLString);
}

@end
