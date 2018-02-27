//
//  ZXAudioUtils.m
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXAudioUtils.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation ZXAudioUtils

+ (void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)takeMedicineAudio{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TakeMedicine" ofType:@"caf"];
    if (path) {
        SystemSoundID sound;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        if (error == kAudioServicesNoError) {
            AudioServicesPlaySystemSound(sound);
        }else{
            [self vibrate];
        }
    }
}

@end
