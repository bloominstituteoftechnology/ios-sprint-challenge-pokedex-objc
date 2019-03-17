//
//  ALWDetailViewController.m
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

#import "ALWDetailViewController.h"
#import "ALWPokemon.h"
#import "Pokedex_ObjC_Sprint_Challenge-Swift.h"

@interface ALWDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation ALWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pokemon.name == nil) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateViews];
}

- (void)updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        self.idLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.pokemonID];
        self.abilitiesLabel.text = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        
        NSURL *url = [NSURL URLWithString:self.pokemon.sprite];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:data];
        });
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}


@end
