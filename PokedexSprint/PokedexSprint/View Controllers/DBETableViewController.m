//
//  DBETableViewController.m
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

#import "DBETableViewController.h"
#import "DBEPokemon.h"

#import "PokedexSprint-Swift.h"

@interface DBETableViewController ()

//@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic) NSArray<DBEPokemon *> *pokemon;

@end

@implementation DBETableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemon = @[];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateViews];
}

- (void)updateViews
{

    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<DBEPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to fetch pokemon with error: %@", error);
            return;
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Pokemon array was nil");
            return;
        }
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [self.pokemon[indexPath.row].name capitalizedString];
    
    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetailSegue"]) {
        DBEDetailViewController *detailVC = (DBEDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemon = self.pokemon[indexPath.row];
    }
}

@end
