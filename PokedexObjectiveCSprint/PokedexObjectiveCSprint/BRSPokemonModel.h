//
//  BRSPokemonModel.h
//  PokedexObjectiveCSprint
//
//  Created by BrysonSaclausa on 12/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRSPokemonModel : NSObject

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSString *identifier;
@property (nonatomic, copy, nullable) UIImage *sprite;
@property (nonatomic, copy, nullable) NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName identifier:(NSString *)identifier;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END


/*
 name
 id
 sprite
 abilities
 */
