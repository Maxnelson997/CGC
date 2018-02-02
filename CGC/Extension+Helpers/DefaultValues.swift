//
//  DefaultValues.swift
//  CGC
//
//  Created by Max Nelson on 1/29/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import UIKit

class DefaultValues {
    
    static let shared = DefaultValues()
    
    var icon = #imageLiteral(resourceName: "GPYAYSmallIcon")
    var semesterTitle = "Spring 18"
    var themeColor:UIColor = .gitCommitGreen
    var themeTitleColor:UIColor = .black
    var themeWasChanged:Bool = false
    var colors:[UIColor] = [
        .appleBlue,
        .aplGreen,
        UIColor.yellow.withAlphaComponent(0.8),
        .grayButton,
        .orangeTheme,
        .tealColor,
        .radicalRed,
        .gotGreen,
        .butBlue,
        .poppinPurple,
        .gitCommitGreen,
        .garbageGolden
    ]
    var theme:ThemeColor?

    let ANIMALS_PACK:[UIImage] = [
        UIImage(named: "anteater.png")!,
        UIImage(named: "bat")!,
        UIImage(named: "beetle")!,
        UIImage(named: "bulldog")!,
        UIImage(named: "butterfly")!,
        UIImage(named: "cat.png")!,
        UIImage(named: "chameleon.png")!,
        UIImage(named: "clown-fish.png")!,
        UIImage(named: "cobra.png")!,
        UIImage(named: "crab.png")!,
        UIImage(named: "crocodile.png")!,
        UIImage(named: "duck.png")!,
        UIImage(named: "elephant.png")!,
        UIImage(named: "giraffe.png")!,
        UIImage(named: "hen.png")!,
        UIImage(named: "hippopotamus.png")!,
        UIImage(named: "kangaroo.png")!,
        UIImage(named: "llama.png")!,
        UIImage(named: "macaw.png")!,
        UIImage(named: "monkey.png")!,
        UIImage(named: "moose.png")!,
        UIImage(named: "octopus.png")!,
        UIImage(named: "ostrich.png")!,
        UIImage(named: "owl.png")!,
        UIImage(named: "panda.png")!,
        UIImage(named: "penguin.png")!,
        UIImage(named: "pig.png")!,
        UIImage(named: "rabbit.png")!,
        UIImage(named: "racoon.png")!,
        UIImage(named: "rhinoceros.png")!,
        UIImage(named: "sea-cow.png")!,
        UIImage(named: "shark.png")!,
        UIImage(named: "sheep.png")!,
        UIImage(named: "sloth.png")!,
        UIImage(named: "snake.png")!,
        UIImage(named: "spider.png")!,
        UIImage(named: "squirrel.png")!,
        UIImage(named: "tiger.png")!,
        UIImage(named: "toucan.png")!,
        UIImage(named: "turtle.png")!,
        UIImage(named: "whale.png")!,
        ]
    
    let AUDIO_PACK:[UIImage] = [
        UIImage(named: "acoustic-guitar")!,
        UIImage(named: "cassette")!,
        UIImage(named: "cloud-computing-1")!,
        UIImage(named: "cloud-computing")!,
        UIImage(named: "drum-1.png")!,
        UIImage(named: "drum")!,
        UIImage(named: "equalizer")!,
        UIImage(named: "harp")!,
        UIImage(named: "headset-1")!,
        UIImage(named: "headset.png")!,
        UIImage(named: "home-cinema.png")!,
        UIImage(named: "ipod-1")!,
        UIImage(named: "ipod-2.png")!,
        UIImage(named: "ipod")!,
        UIImage(named: "jack")!,
        UIImage(named: "keyboard")!,
        UIImage(named: "lyre")!,
        UIImage(named: "microphone-2")!,
        UIImage(named: "microphone-3")!,
        UIImage(named: "microphone")!,
        UIImage(named: "music-player")!,
        UIImage(named: "music")!,
        UIImage(named: "radio-1")!,
        UIImage(named: "radio-2")!,
        UIImage(named: "radio-3")!,
        UIImage(named: "recorder")!,
        UIImage(named: "speaker-3")!,
        UIImage(named: "speaker")!,
        UIImage(named: "trumpet")!,
        UIImage(named: "turntable")!,
        UIImage(named: "vinyl")!,
        UIImage(named: "violin")!,
        UIImage(named: "walkman")!,
        UIImage(named: "xylophone")!,
        ]
}
