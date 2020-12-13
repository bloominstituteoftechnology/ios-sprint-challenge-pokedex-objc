//
//  Results.h
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import <Foundation/Foundation.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface Results : NSObject

@property NSArray<Pokemon *> *pokemonResults;

- (instancetype)initWithArray:(NSArray<Pokemon *> *)anArray;
- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@end

NS_ASSUME_NONNULL_END
