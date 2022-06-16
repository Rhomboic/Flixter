//
//  FlixViewController.m
//  Flixter
//
//  Created by Adam Issah on 6/15/22.
//

#import "FlixViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CustomCell.h"
#import "DetailsViewController.h"

@interface FlixViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movieArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end



@implementation FlixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    
    [self.activityIndicator startAnimating];
    [self fetchData];
    [self.activityIndicator stopAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
}

- (void)fetchData {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=8079a45ef0970ad61179c51c1a1b1db4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//               NSLog(@"%@", dataDictionary);

               // TODO: Get the array of movies
               NSArray *movieArray = dataDictionary[@"results"];
//               for (NSString* currentString in movieArray)
//               {
//                   NSLog(@"%@", currentString);
//                   NSLog(@"%@", @"\n\nlogged\n\n");
//               }
               // TODO: Store the movies in a property to use elsewhere
               self.movieArray = movieArray;
               // TODO: Reload your table view data
               [self.tableView reloadData];
           }
        NSLog(@"Loaded!");
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    cell.movieTitle.text = self.movieArray[indexPath.row][@"title"];
    cell.movieTitle.font = [cell.movieTitle.font fontWithSize:16];
    cell.movieTitle.lineBreakMode = NSLineBreakByWordWrapping;
    cell.movieTitle.numberOfLines = 0;
    
    cell.movieSummary.text = self.movieArray[indexPath.row][@"overview"];
    cell.movieSummary.font = [cell.movieSummary.font fontWithSize:12];
    cell.movieSummary.lineBreakMode = NSLineBreakByWordWrapping;
    cell.movieSummary.numberOfLines = 0;
    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *movieImageURL = [ baseURL stringByAppendingString: self.movieArray[indexPath.row][@"poster_path"] ];
    [cell.moviePoster setImageWithURL:[ NSURL URLWithString:movieImageURL ]];
    self.tableView.rowHeight = 180;
    
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    DetailsViewController *detailView = [segue destinationViewController];
    detailView.thisMovie = self.movieArray[indexPath.row];
    
//     Pass the selected object to the new view controller.
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
