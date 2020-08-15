//
//  XMPPokedexDetailViewController.m
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import "XMPPokedexDetailViewController.h"
#import "pokedex_objc-Swift.h"

@interface XMPPokedexDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAbilityLabel;

@end

@implementation XMPPokedexDetailViewController

-(void)updateViews {
    NSLog(@"updateViews()");
    _nameLabel.text = _pokemon.name;
    _idLabel.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)_pokemon.identifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PokemonAPI *fetcher = [PokemonAPI new];
    [fetcher fillInDetailsFor:_pokemon];
    [self updateViews];
}

@end
