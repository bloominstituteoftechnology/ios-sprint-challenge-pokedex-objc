//
//  PokemonDetailViewController.m
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/22/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokedex_ObjC-Swift.h"
#import "Pokemon.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

@property (weak,nonatomic) IBOutlet UIImageView *pokemonImage;
@property (retain, nonatomic) IBOutlet UILabel *pokemonName;
@property (retain, nonatomic) IBOutlet UILabel *pokemonID;
@property (retain, nonatomic) IBOutlet UILabel *pokemonAbilities;

@end

@implementation PokemonDetailViewController

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

- (void)dealloc {
    [_pokemonName release];
    [_pokemonID release];
    [_pokemonAbilities release];
    [super dealloc];
}
@end
