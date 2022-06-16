//
//  CustomCell.h
//  Flixter
//
//  Created by Adam Issah on 6/15/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieSummary;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@end

NS_ASSUME_NONNULL_END
