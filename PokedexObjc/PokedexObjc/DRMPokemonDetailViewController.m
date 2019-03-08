//
//  DRMPokemonDetailViewController.m
//  PokedexObjc
//
//  Created by Dillon McElhinney on 3/8/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMPokemonDetailViewController.h"

@interface DRMPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;

@end

@implementation DRMPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

- (void)updateViews {
    if (self.pokemon != nil) {
        self.title = [self.pokemon.name capitalizedString];
        
        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", (self.pokemon.identifier == nil) ? @"" : self.pokemon.identifier];
        self.abilityLabel.text = [NSString stringWithFormat:@"Abilities:\n%@", self.pokemon.name];
    }
}

@end
