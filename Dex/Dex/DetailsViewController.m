//
//  DetailsViewController.m
//  Dex
//
//  Created by Ezra Black on 6/19/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

#import "DetailsViewController.h"
#import "CNSPokemon.h"
#import "Dex-Swift.h"


void *KVOContext = &KVOContext;

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonId;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilities;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNSPokemonController.sharedController UPDATEWithPokemon: self.pokemon];
}

- (void)updateViews
{
    if (!self.pokemon || self.isViewLoaded) { return; }
    self.pokemonName.text = self.pokemon.name;
    self.pokemonId.text = [NSString stringWithFormat:@"%d", self.pokemon.id];
    self.pokemonAbilities.text = [self.pokemon.abilities componentsJoinedByString:@", "];
    NSData *image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.pokemon.sprites]];
    self.pokemonImage.image = [[UIImage alloc] initWithData:image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
