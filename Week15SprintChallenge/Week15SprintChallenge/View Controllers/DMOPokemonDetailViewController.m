//
//  DMOPokemonDetailViewController.m
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPokemonDetailViewController.h"
#import "DMOPokemon.h"
#import "Week15SprintChallenge-Swift.h"

@interface DMOPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DMOPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) updateViews {
    
    DMOPokemon *pokemon = PokemonAPI.sharedController.pokemon;
    
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", [pokemon.name capitalizedString]];
    self.idLabel.text = [NSString stringWithFormat:@"ID: %i", pokemon.idenitifier];
    self.abilitiesLabel.text =  [NSString stringWithFormat:@"Abilities:\n\n%@", [pokemon.abilities capitalizedString]];
    
    
    
    
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
