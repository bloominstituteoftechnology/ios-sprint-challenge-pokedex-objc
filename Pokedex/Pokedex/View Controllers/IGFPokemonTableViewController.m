//
//  IGFPokemonTableViewController.m
//  Pokedex
//
//  Created by Ian French on 12/12/20.
//

#import "IGFPokemonTableViewController.h"
#import "IGFPokemonDetailViewController.h"
#import "IGFPokemonController.h"
#import "IGFPokemonModel.h"

@interface IGFPokemonTableViewController ()

@property (nonatomic) IGFPokemonController *pokemonController;

@end



@implementation IGFPokemonTableViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[IGFPokemonController alloc] init];
    }
    return self;
}

static NSString * const reuseIdentifier = @"PokemonCell";




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pokemonController fetchPokemonFromAPI:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.pokemonController getPokemons].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.pokemonController getPokemons][indexPath.row].name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    IGFPokemonDetailViewController *detailVC = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"PokemonDetailSegue"])
    {
        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemonController = self.pokemonController;
        detailVC.pokemon = [self.pokemonController getPokemons][indexPath.row];
    }
}


@end
