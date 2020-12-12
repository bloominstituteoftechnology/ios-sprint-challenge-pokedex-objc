//
//  BRSPokemonModel.h
//  PokedexObjectiveCSprint
//
//  Created by BrysonSaclausa on 12/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRSPokemonModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *identifier;
@property (nonatomic) UIImage *sprite;
@property (nonatomic) NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName;

@end

NS_ASSUME_NONNULL_END


/*
 name
 id
 sprite
 abilities
 */
