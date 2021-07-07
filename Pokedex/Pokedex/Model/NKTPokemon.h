//
//  NKTPokemon.h
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NKTPokemon : NSObject

@property (nonatomic, strong) NSString *detailURL;
@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger pokemonID;
@property (nonatomic, strong) NSArray<NSString *> *abilities;


// For tableView before we've loaded the rest of the info
- (instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL;

// For detail view when we're loading the object with the full details
- (instancetype)initWithName:(NSString *)name pokemonID:(NSInteger)pokemonID detailURL:(NSString *)detailURL imageURL:(NSString *)imageURL abilities:(NSArray *)abilities;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
