//
//  EFSPokemon.h
//  PokedexObjcSprint
//
//  Created by Clayton Watkins on 10/9/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFSPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readwrite)NSNumber *identifier;
@property (nonatomic, readwrite)UIImage *sprite;
@property (nonatomic, readwrite, copy)NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
