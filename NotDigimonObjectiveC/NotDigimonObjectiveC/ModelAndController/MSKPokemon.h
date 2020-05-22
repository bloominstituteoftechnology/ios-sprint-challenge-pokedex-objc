//
//  MSKPokemon.h
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSKSprites;
@class MSKAbility;
@class MSKMove;
@class MSKSpecies;
NS_ASSUME_NONNULL_BEGIN

@interface MSKPokemon: NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, assign) NSInteger *identifier;
@property (nonatomic, assign) MSKSprites *sprites;
@property (nonatomic, copy) NSArray<MSKAbility *> *abilities;

-(instancetype)initWithName:(NSString *)name
                 identifier:(NSInteger *)identifier
                    sprites:(MSKSprites *)sprites
                  abilities:(NSArray<MSKAbility *> *)abilities;
-(instancetype)InitWithDict:(NSDictionary *)dict;
@end

@interface MSKSprites: NSObject
@property (nonatomic, copy) NSString *frontShiny;
-(instancetype)initwWithFrontShiny:(NSString *)frontShiny;
@end

@interface MSKAbility: NSObject
@property (nonatomic, strong) MSKSpecies *ability;
-(instancetype)initWithAbility:(MSKSpecies *)ability;
@end

@interface MSKSpecies: NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
-(instancetype)initWithName:(NSString *)name
                        url:(NSString *)url;
@end
NS_ASSUME_NONNULL_END
