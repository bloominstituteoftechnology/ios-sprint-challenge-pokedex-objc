//
//  CCCDetialViewController.m
//  PokemonObjC
//
//  Created by Ryan Murphy on 7/26/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

#import "CCCDetialViewController.h"
#import "CCCPokemon.h"
#import "PokemonObjC-Swift.h"


@interface CCCDetialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iDLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokeImageView;

@end

@implementation CCCDetialViewController

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


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}

- (void)updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        self.iDLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.pokemonID];
        self.abilityLabel.text = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        
        NSURL *url = [NSURL URLWithString:self.pokemon.sprite];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokeImageView.image = [UIImage imageWithData:data];
        });
    }
}








@end
