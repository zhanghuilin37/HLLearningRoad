//
//  MediaRecordAndPlayer.m
//  demo
//
//  Created by Zhl on 16/9/30.
//  Copyright © 2016年 LearningRoad. All rights reserved.
//

#import "MediaRecordAndPlayer.h"
#import "ProgressHUD.h"
@interface MediaRecordAndPlayer ()<AVAudioRecorderDelegate>
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@end

@implementation MediaRecordAndPlayer
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+(instancetype)shareInstance{
    static MediaRecordAndPlayer *rp = nil;
    if (rp == nil) {
        rp = [[MediaRecordAndPlayer alloc] init];
    }
    return rp;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //添加监听
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(sensorStateChange:)
         
                                                     name:@"UIDeviceProximityStateDidChangeNotification"
         
                                                   object:nil];
    }
    return self;
}
/**
 *  结束录音
 */
- (void)endRecord:(id)sender
{
    [self.audioRecorder stop];
}

/**
 *  设置音频会话
 */
-(void)setAudioSession{
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[MediaRecordAndPlayer getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatMPEGLayer3) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //录音的质量
    [dicM setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    //    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    //....其他设置等
    return dicM;
}

#pragma mark - 录音机代理方法
/**
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音完成!");
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    NSLog(@"录音失败");
}

//扬声器与听筒转换
- (void)sensorStateChange:(NSNotification *)notification
{
    if ([[UIDevice currentDevice] proximityState] == YES)
        
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
+(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:@"kRecordAudioFile.aac"];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}
#pragma mark - 删除录音
- (void)removeVoice
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [[MediaRecordAndPlayer getSavePath] path];
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:filePath error:&error];
        if (success) {
            NSLog(@"录音删除成功!");
        }
        else
        {
            NSLog(@"录音删除失败 -:%@ ",[error localizedDescription]);
        }
        
    });
}
-(NSData*)getRecordData{
    
    NSData *sendData = [NSData dataWithContentsOfURL:[MediaRecordAndPlayer getSavePath]];
    return sendData;
}
-(void)begainRecord{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            [self setAudioSession];
            if (![self.audioRecorder isRecording]) {
                //首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
                [self.audioRecorder record];
                return;
            }
        } else {
            [ProgressHUD showError:@"用户未允许使用麦克风"];
        }
    }];

}
@end
