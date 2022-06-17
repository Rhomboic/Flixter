//
//  FlixCollViewController.m
//  Flixter
//
//  Created by Adam Issah on 6/16/22.
//

#import "FlixCollViewController.h"
#import "UIImageView+AFNetworking.h"
#import "CustomGridCell.h"
#import "DetailsViewController.h"

@interface FlixCollViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *movieCollView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *movieArray;

@end

@implementation FlixCollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieCollView.dataSource = self;
    [self fetchData];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:(UIControlEventValueChanged)];
    [self.movieCollView insertSubview:self.refreshControl atIndex:0];
    // Do any additional setup after loading the view.
//    self.
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


               // TODO: Get the array of movies
               NSArray *movieArray = dataDictionary[@"results"];
               // TODO: Store the movies in a property to use elsewhere
               self.movieArray = movieArray;
               // TODO: Reload your table view data
               [self.movieCollView reloadData];
               [self.refreshControl endRefreshing];
               
               
               
           }
        NSLog(@"Loaded!");
        
       }];
    [task resume];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomGridCell *cell = [self.movieCollView dequeueReusableCellWithReuseIdentifier:@"CustomGridCell" forIndexPath:indexPath];
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *movieImageURL = [ baseURL stringByAppendingString: self.movieArray[indexPath.row][@"poster_path"] ];
    [cell.posterImage setImageWithURL:[ NSURL URLWithString:movieImageURL ]];
//    self.movieCollView.
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;

}
//- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
////    return _movieArray.count;
//    return 1;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
    UICollectionViewCell *cell = sender;
    NSIndexPath *indexPath = [self.movieCollView indexPathForCell:cell];
    
    DetailsViewController *detailView = [segue destinationViewController];
    detailView.thisMovie = self.movieArray[indexPath.row];
    
//     Pass the selected object to the new view controller.
}
@end
