//
//  JLHeaderView.m
//  02-QQ好友列表
//
//  Created by XinYou on 15-3-6.
//  Copyright (c) 2015年 vxinyou. All rights reserved.
//

#import "JLHeaderView.h"
#import "JLFriendGroup.h"


@interface JLHeaderView()

/**
 *  组名
 */
@property (nonatomic,weak)UIButton *nameView;
/**
 *  该组在线人数
 */
@property (nonatomic,weak)UILabel *countView;

@end

@implementation JLHeaderView



+ (instancetype)headViewWithTableView:(UITableView *)tableView{

    static NSString *ID = @"header";
    // 在JLHeaderView.h中我们留下了一个疑问——“既然是自定义headerView，为什么还需要继承UItableViewHeaderFooterView，而不是继承UIView呢？”
    // 因为继承UItableViewHeaderFooterView可以像UITableViewCell一样对headerView进行复用，提升性能
    JLHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    // 在初始化方法中添加headerView的子控件
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        // 1,添加组名控件
        UIButton *nameView = [[UIButton alloc] init];
        //    UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];//和上面一句代码的作用一样
//        nameView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        // 设置按钮的背景图片
        [self.nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [self.nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮的文本内容与文本内容所在区域的边距
        self.nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置按钮的内容与按钮四条边的边距
        self.nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置按钮的内容水平方向左对齐
        self.nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的字体颜色
        [self.nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮内部文字左边的图片
        [self.nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        // UIViewContentModeCenter : contents remain same size. positioned adjusted.
        // 意思是大小不变，位置居中。
        // 假设imageView的高>宽，当imageView旋转90度后，就会变成宽>高，
        // 虽然居中显示，但是imageView的左边和右边还是会超出边框,所以还需要设置“超出边框的内容不需要裁剪”
        self.nameView.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        self.nameView.imageView.clipsToBounds = NO;
        
        // 给nameView设置监听
        [self.nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 此时self.bounds还没有值，这是为什么呢？因为这是UITableViewHeaderFooterView的初始化方法
        // 假设我们初始化一个UILabel：UILabel *label = [[UILable alloc] init],
        // 经过这句代码后label的frame或者bounds属性都还是没有值的。
//        self.nameView.frame = self.bounds;
        
        // 2,添加在线人数控件
        UILabel *countView = [[UILabel alloc] init];
//        countView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:countView];
        self.countView = countView;
        // 设置UILabel中的文本右对齐
        self.countView.textAlignment = NSTextAlignmentRight;
        // 设置UILabel的文本颜色
        self.countView.textColor = [UIColor grayColor];
        
        // 不能在这里设置frame
//        self.countView.frame = CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
    }
    
    return self;
}

/**
 *  当一个控件的frame发生改变的时候就会调用
 *  一般在这个方法中设置子控件的frame
 */
- (void)layoutSubviews{
    // 一定要调用父类的方法
    [super layoutSubviews];

    // 设置nameView这个Button填充父控件
    self.nameView.frame = self.bounds;

    // 设置countView与父控件左边距为10，宽度150，高度=父控件高度
    CGFloat padding = 10;
    CGFloat countW = 150;
    CGFloat countX = self.frame.size.width - padding - countW;
    CGFloat countY = 0;
    CGFloat countH = self.frame.size.height;
    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)setGroup:(JLFriendGroup *)group{

    _group = group;
    
    // 设置组名
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    
    // 设置在线人数
    self.countView.text = [NSString stringWithFormat:@"%d/%d", group.online, group.friends.count];
}

- (void)nameViewClick{
    // 设置该组的打开状态，对上一次状态取反
    self.group.opened = !self.group.isOpened;
    
    // 通知代理(控制器)，刷新数据
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickNameView:)]) {
        [self.delegate headerViewDidClickNameView:self];
    }
    
}
/**
 *  当一个控件被添加到父控件中就会调用
 *  在这里控制控制组名左边图片的旋转
 
    为什么在这里控制图片的旋转呢？
    当某组的headerView中的nameView被点击，触发了nameViewClick方法，该组的opened状态改变，然后控制器刷新数据
    注意这里的刷新数据，会把之前UITableView中的数据全部销毁，然后全部重新创建，重新创建就需要把headerView添加到UITableView中。
    所以didMoveToSuperView在每次刷新数据后都会调用，也就是每次点击nameView后都会调用
 
 */
- (void)didMoveToSuperview{
    
    if (self.group.opened) {
        // M_PI_2表示π/2 , M_2_PI表示2π
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
