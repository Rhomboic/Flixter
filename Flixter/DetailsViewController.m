//
//  DetailsViewController.m
//  Flixter
//
//  Created by Adam Issah on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundPoster;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UITextView *movieSummary;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.movieTitle.text = self.thisMovie[@"title"];
    self.movieTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.movieTitle.numberOfLines = 0;
    self.movieSummary.text = self.thisMovie[@"overview"];
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *movieImageURL = [ baseURL stringByAppendingString: self.thisMovie[@"poster_path"] ];
    [self.moviePoster setImageWithURL:[ NSURL URLWithString:movieImageURL ]];
    NSString *movieBackgroundImageURL = [ baseURL stringByAppendingString: self.thisMovie[@"backdrop_path"] ];
    [self.moviePoster setImageWithURL:[ NSURL URLWithString:movieImageURL ]];
    [self.backgroundPoster setImageWithURL:[ NSURL URLWithString:movieBackgroundImageURL ]];
    
    NSLog(@"@%@", self.thisMovie);
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
