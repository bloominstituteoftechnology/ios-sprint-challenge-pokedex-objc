//
//  JDFPokemonDetailViewController.m
//  Pokedex
//
//  Created by Jonathan Ferrer on 7/26/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

#import "JDFPokemonDetailViewController.h"
#import "JDFPokemon.h"

@interface JDFPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;

@end

@implementation JDFPokemonDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];

    if (self.pokemon.identifier == nil) {
        [self.pokemon addObserver: self forKeyPath: @"abilities" options: 0 context: nil];
    }
}

- (void)updateViews {
    if (self.pokemon != nil) {
        self.title = [self.pokemon.name capitalizedString];

        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", (self.pokemon.identifier == nil) ? @"" : self.pokemon.identifier];
        self.abilityLabel.text = [NSString stringWithFormat:@"Abilities:\n%@", self.pokemon.abilityString];

        if (self.pokemon.spriteURL != nil) {
            NSData *imageData = [NSData dataWithContentsOfURL: self.pokemon.spriteURL];
            UIImage *image = [UIImage imageWithData: imageData];
            self.imageView.image = image;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}

@end

