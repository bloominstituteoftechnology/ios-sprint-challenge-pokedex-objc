//
//  FAFDetailViewController.m
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import "FAFDetailViewController.h"
#import "PokedexObjC-Swift.h"

void *KVOContext = &KVOContext;

@interface FAFDetailViewController ()
    
@property (weak, nonatomic) IBOutlet UIImageView *pokeView;
    
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@property (weak, nonatomic) IBOutlet UILabel *baseXPLabel;
    
@property (weak, nonatomic) IBOutlet UILabel *typesLabel;
    
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;
    
    
    
@end

@implementation FAFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[FAFPokemonAPI sharedController] fillInDetailsFor:[self pokemon]];
}
    
-(void)setPokemon:(FAFPokemon *)pokemon
{
    if (pokemon != _pokemon)
    {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"weight" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}
    
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self updateViews];
                       });
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
    
- (void)updateViews
{
    
    self.nameLabel.text = [NSString stringWithFormat:@"Name : %@", self.pokemon.name.capitalizedString];
    
    NSString *abilities = [NSString stringWithFormat:@"Abilities: %@", [[[self pokemon] abilities] componentsJoinedByString:@" , "]];
    self.abilitiesLabel.text = abilities;
    NSString *types = [NSString stringWithFormat:@"Types: %@", [[[self pokemon] types] componentsJoinedByString:@" + "]];
    self.typesLabel.text = types;
    self.weightLabel.text = [NSString stringWithFormat:@"Weight: %li", self.pokemon.weight];
    self.idLabel.text = [NSString stringWithFormat:@"ID: %li", self.pokemon.pokemonID];
    self.baseXPLabel.text = [NSString stringWithFormat:@"Base XP: %li", self.pokemon.baseXP];
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
