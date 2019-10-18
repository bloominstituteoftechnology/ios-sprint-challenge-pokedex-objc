//
//  JSPokeDetailsVC.h
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PokeController;

NS_ASSUME_NONNULL_BEGIN

@interface JSPokeDetailsVC : UIViewController

@property PokeController *pokecontroller;
@property (copy) NSString *pokeName;

@end

NS_ASSUME_NONNULL_END
