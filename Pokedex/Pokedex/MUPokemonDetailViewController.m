//
//  MUPokemonDetailViewController.m
//  Pokedex
//
//  Created by Moin Uddin on 11/30/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

#import "MUPokemonDetailViewController.h"

@interface MUPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;

@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonIdLabel;

@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilitiesLabel;


@end

@implementation MUPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
