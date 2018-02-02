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
    
    let EDU_PACK:[UIImage] = [
        UIImage(named: "abacus")!,
        UIImage(named: "blackboard")!,
        UIImage(named: "books")!,
        UIImage(named: "diploma")!,
        UIImage(named: "eyeglasses")!,
        UIImage(named: "flask")!,
        UIImage(named: "nerd")!,
        UIImage(named: "owl")!,
        UIImage(named: "school-bell")!,
        UIImage(named: "test")!,
        UIImage(named: "thinking")!,
        UIImage(named: "chemistry")!,
        UIImage(named: "degree")!,
        UIImage(named: "library")!,
        UIImage(named: "microscope")!,
        UIImage(named: "school")!,
        UIImage(named: "science")!,
        ]
    
    let SPACE_ONE_PACK:[UIImage] = [
        UIImage(named: "006-earth")!,
        UIImage(named: "002-saturn")!,
        UIImage(named: "003-jupiter")!,
        UIImage(named: "004-mars")!,
        UIImage(named: "007-venus")!,
        UIImage(named: "001-uranus")!,
        UIImage(named: "010-alien")!,
        UIImage(named: "009-telescope")!,
        UIImage(named: "008-robot")!,
        UIImage(named: "012-blaster")!,
        UIImage(named: "015-rocket")!,
        UIImage(named: "014-rocket")!,
        UIImage(named: "013-astronaut")!,
        UIImage(named: "017-solar-system")!,
        UIImage(named: "018-satellite-1")!,
        UIImage(named: "019-planet")!,
        UIImage(named: "025-sun")!,
        UIImage(named: "024-nepture")!,
        UIImage(named: "023-pluto")!,
        UIImage(named: "022-asteroid")!,
        UIImage(named: "020-satellite")!,
        ]

    let SPACE_TWO_PACK:[UIImage] = [
        UIImage(named: "alien-1")!,
        UIImage(named: "alien")!,
        UIImage(named: "astronaut")!,
        UIImage(named: "robot")!,
        UIImage(named: "saturn")!,
        UIImage(named: "shooting-star")!,
        UIImage(named: "telescope")!,
        UIImage(named: "ufo")!,
        UIImage(named: "001-sun")!,
        UIImage(named: "009-alien-1")!,
        UIImage(named: "009-alien")!,
        UIImage(named: "009-astronaut")!,
        UIImage(named: "009-robot")!,
        UIImage(named: "009-shooting-star")!,
        UIImage(named: "009-telescope")!,
        UIImage(named: "009-ufo")!,
        UIImage(named: "002-satellite-desih")!,
        UIImage(named: "003-astronaut")!,
        UIImage(named: "004-telescope")!,
        UIImage(named: "005-ufo")!,
        UIImage(named: "006-alien")!,
        UIImage(named: "007-rocket")!,
        UIImage(named: "008-moon")!,
        UIImage(named: "009-planets")!,
        UIImage(named: "010-satellite-1")!,
        UIImage(named: "011-saturn")!,
        UIImage(named: "012-stars")!,
        UIImage(named: "013-space-ship")!,
        UIImage(named: "014-planet-earth")!,
        UIImage(named: "015-meteorite")!,
        UIImage(named: "016-satellite")!
    ]
    
    let SPACE_THREE_PACK = [
        UIImage(named: "comet")!,
        UIImage(named: "eclipse-1")!,
        UIImage(named: "flag")!,
        UIImage(named: "galaxy-1")!,
        UIImage(named: "moon-1")!,
        UIImage(named: "moon")!,
        UIImage(named: "observatory")!,
        UIImage(named: "planet-earth")!,
        UIImage(named: "robot")!,
        UIImage(named: "rocket-ship")!,
        UIImage(named: "satellite-dish-1")!,
        UIImage(named: "satellite-dish")!,
        UIImage(named: "satellite")!,
        UIImage(named: "saturn")!,
        UIImage(named: "solar-system")!,
        UIImage(named: "space-shuttle")!,
        UIImage(named: "telescope")!,
        UIImage(named: "ufo-1")!,
        UIImage(named: "ufo")!,
        UIImage(named: "universe")!
    ]
    
    let ICON_TEMPLATE = [
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,
        UIImage(named: "")!,]
    
}
