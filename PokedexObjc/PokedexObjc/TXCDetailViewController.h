//
//  TXCDetailViewController.h
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXCPokemon;
NS_ASSUME_NONNULL_BEGIN

@interface TXCDetailViewController : UIViewController

@property (nonatomic, nullable) TXCPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
