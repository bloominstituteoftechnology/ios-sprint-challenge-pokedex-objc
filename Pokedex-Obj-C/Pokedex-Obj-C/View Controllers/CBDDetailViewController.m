//
//  CBDDetailViewController.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDDetailViewController.h"
#import "CBDPokemonShort.h"
#import "CBDPokemon.h"
#import "Pokedex_Obj_C-Swift.h"

@interface CBDDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *spriteImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation CBDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    [self.networkController fillInDetailsFor:self.pokemonShort completion:^(CBDPokemon *_Nullable pokemon, NSError *_Nullable error) {
        self.pokemon = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }];
}

- (void)updateViews {
    NSString *name = [NSString stringWithFormat:@"Name: %@", self.pokemonShort.name];
    [self.nameLabel setText:name];

}

@end
