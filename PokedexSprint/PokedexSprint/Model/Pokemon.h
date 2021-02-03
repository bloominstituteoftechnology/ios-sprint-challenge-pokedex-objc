//
//  Pokemon.h
//  PokedexSprint
//
//  Created by Norlan Tibanear on 1/31/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, nonnull)NSNumber *identifier;
@property (nonatomic, nullable)UIImage *sprite;
@property (nonatomic, nonnull, copy)NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
