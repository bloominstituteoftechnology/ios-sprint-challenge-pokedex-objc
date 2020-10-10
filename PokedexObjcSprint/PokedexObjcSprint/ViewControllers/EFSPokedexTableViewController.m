//
//  EFSPokedexTableViewController.m
//  PokedexObjcSprint
//
//  Created by Clayton Watkins on 10/9/20.
//

#import "EFSPokedexTableViewController.h"
#import "EFSPokemon.h"
#import "PokedexObjcSprint-Swift.h"

@interface EFSPokedexTableViewController ()

@property (nonatomic, nonnull) NSArray<EFSPokemon *> *pokemon;

@end

@implementation EFSPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [EFSPokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<EFSPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pokemon = pokemon;
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    EFSPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


}


@end
