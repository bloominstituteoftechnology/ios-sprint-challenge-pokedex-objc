//
//  IGFPokemonModel.h
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface IGFPokemonModel : NSObject


@property (nonatomic, copy, nonnull) NSURL *detailsURL;
@property (nonatomic, copy, nonnull) NSString *name;
@property (nonatomic) int pokemonId;
@property (nonatomic, nonnull) NSMutableArray *abilities;
@property (nonatomic, nonnull) UIImage *pokemonSprite;

- (instancetype _Nonnull)initWithDictionary:(nonnull NSDictionary *)dictionary;

- (void)pokemonDetailsWithDictionary:(nonnull NSDictionary *)dictionary;

@end


