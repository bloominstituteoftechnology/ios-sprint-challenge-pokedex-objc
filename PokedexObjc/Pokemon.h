//
//  Pokemon.h
//  PokedexObjc
//
//  Created by Kenneth Jones on 2/19/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

- (instancetype)initWithIdentifier:(int)anIdentifier
                              name:(NSString *)aName
                            sprite:(NSString *)aSprite
                         abilities:(NSString *)someAbilities NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@property (nonatomic, readonly) int identifier;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *sprite;
@property (nonatomic, readonly, copy) NSString *abilities;

@end

NS_ASSUME_NONNULL_END
