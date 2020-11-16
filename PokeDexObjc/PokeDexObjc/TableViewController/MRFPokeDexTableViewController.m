//
//  MRFPokeDexTableViewController.m
//  PokeDexObjc
//
//  Created by Michael Flowers on 7/26/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFPokeDexTableViewController.h"
#import "MRFPokemon.h"

@interface MRFPokeDexTableViewController ()
//@property NSMutableArray *internalPokemons;
@property NSArray< MRFPokemon *> *returnedPokemons;
@end

@implementation MRFPokeDexTableViewController

//initialize mutable array
//-(instancetype)init {
//    self = [super init];
//
//    if (self){
//        _internalPokemons = [[NSMutableArray alloc]init];
//    }
//    return self;
//}

//INITIALIZE the network as a lazy property
//-(MRFNetwork *)network {
//    if (_network == nil){
//        _network = [[MRFNetwork alloc] init];
//    }
//    return _network;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //test the network call
   MRFNetwork *network = [[MRFNetwork alloc] init];
    [network fetchAllPokemonWithCompletion:^(NSArray<MRFPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error in the tblvc: %@",error);
        }
        NSLog(@"pokemon.count %li", pokemons.count);
        self.returnedPokemons = pokemons;
//        [self.internalPokemons addObjectsFromArray:pokemons];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"print internalPokemons:%li", self.internalPokemons.count);
            [self.tableView reloadData];
            self.tableView.backgroundColor = UIColor.blueColor;
        });
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.network.pokemons.count;
//    return self.internalPokemons.count;
    return self.returnedPokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
//    MRFPokemon *pokemon = self.network.pokemons[indexPath.row];
//    MRFPokemon *pokemon = self.internalPokemons[indexPath.row];
    MRFPokemon *pokemon = self.returnedPokemons[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = pokemon.name;
    NSLog(@"pokemons sprite: %@", pokemon.sprite);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
