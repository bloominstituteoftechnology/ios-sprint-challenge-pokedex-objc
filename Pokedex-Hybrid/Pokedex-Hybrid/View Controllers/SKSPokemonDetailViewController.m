//
//  SKSPokemonDetailViewController.m
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSPokemonDetailViewController.h"
#import "SKSPokemonController.h"
#import "SKSPokemon.h"

@interface SKSPokemonDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UILabel *abilitiesLabel;

@end

@implementation SKSPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokemonController fetchDetailsWithPokemonAPIForPokemon:self.pokemon];
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
