//
//  PokemonViewController.m
//  PokeC
//
//  Created by Lotanna Igwe-Odunze on 3/15/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

#import "PokemonViewController.h"

@interface PokemonViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;

@end

@implementation PokemonViewController

//Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
    
    // Adds the observer if there's a change to be made
    if (self.pokemon.identifier == nil) {
        [self.pokemon addObserver: self forKeyPath: @"abilities" options: 0 context: nil];
    }
}

//Show Pokemon information
- (void)updateViews {
    if (self.pokemon != nil) {
        self.title = [self.pokemon.name capitalizedString];
        
        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", (self.pokemon.identifier == nil) ? @"" : self.pokemon.identifier];
        self.abilityLabel.text = [NSString stringWithFormat:@"Abilities:\n %@", self.pokemon.abilityString];
        
        //Checking problem with list of abilities
        NSLog(@"%@", self.pokemon.abilityString);
        
        
        if (self.pokemon.spriteURL != nil) {
            NSData *imageData = [NSData dataWithContentsOfURL: self.pokemon.spriteURL];
            UIImage *image = [UIImage imageWithData: imageData];
            self.pokemonImageView.image = image;
        }
    }
}

//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    
    [object removeObserver:self forKeyPath:keyPath];
}

@end
