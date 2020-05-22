//
//  MSKPokemon.h
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSKSprites
@class MSKAbility
@class MSKMove
@class MSKSpcies
NS_ASSUME_NONNULL_BEGIN

@interface MSKPokemon: NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, assign) NSInteger *identifier;
@property (nonatomic, assign) MSKSprites *sprites;
@property (nonatomic, copy) NSArray<MSKAbility *> *abilities;
@end

@interface MSKSprites: NSObject
@@property (nonatomic, copy) NSString *frontShiny;
@end

@interface MSKAbility: NSObject
@@property (nonatomic, strong) MSKSpecies *ability;
@end

@interface MSKSpecies NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;

NS_ASSUME_NONNULL_END
