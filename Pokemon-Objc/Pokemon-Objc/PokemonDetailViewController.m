//
//  PokemonDetailViewController.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon_Objc-Swift.h"
#import "LSIPokemon.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesListLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNumberLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearViews];
    
    if (self.pokemon) {
        [self updateViews];
        [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
        [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    }
}

- (void)clearViews
{
    self.imageView.image = nil;
    self.nameLabel.text = nil;
    self.abilitiesListLabel.text = nil;
    self.idNumberLabel.text = nil;
}

- (void)updateViews
{
    self.nameLabel.text = [self.pokemon.name capitalizedString];
    self.idNumberLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.identifier];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        NSLog(@"identifier: %@", self.pokemon.identifier);
        NSLog(@"%@", self.pokemon.spriteURLString);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
}

@end
