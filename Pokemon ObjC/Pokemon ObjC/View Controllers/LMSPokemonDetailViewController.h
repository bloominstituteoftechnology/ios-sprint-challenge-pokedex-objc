//
//  LMSPokemonDetailViewController.h
//  Pokemon ObjC
//
//  Created by Lisa Sampson on 3/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMSPokemonDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pokemonSprite;
@property (weak, nonatomic) IBOutlet UILabel *pokemonLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilityTextView;

@end

NS_ASSUME_NONNULL_END
