//
//  AudioConverter.swift
//  DockHider
//
//  Created by Constantin Clerc on 14/01/2023.
//

import AudioKit
import AVFoundation
import SwiftUI
import UIKit

func customaudio(filepath: String) -> String? {
    // Converting options
    var options = FormatConverter.Options()
    options.format = AudioFileFormat.m4a
    options.sampleRate = 11025
    options.bitDepth = 16
    // Temp Path
    let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    let newURL = URL(fileURLWithPath: "\(temporaryDirectoryURL)/audio.m4a")
    // Delete if old file in temp dir
    if FileManager.default.fileExists(atPath: newURL.path) {
        do {
            try FileManager.default.removeItem(at: newURL)
        }
        catch {
            print(error)
        }
    }
    // CONVERT !
    let converter = FormatConverter(inputURL: URL(fileURLWithPath: filepath), outputURL: newURL, options: options)
    converter.start { error in
    }
    // Check file size
    do {
        let attributes = try FileManager.default.attributesOfItem(atPath: newURL.path)
        let fileSize = attributes[FileAttributeKey.size] as! UInt64
        if fileSize > 10_000 {
            UIApplication.shared.alert(body: "You're file is too big. Please crop or compress it to under 10 kB.")
            return nil
        }
    } catch {
        print("Error: Unable to check file size.")
        UIApplication.shared.alert(body: "Unable to verify file size.")
        return nil
    }
    // Base 64 Encoding
    var fileData = Data()
    do{
        fileData = try Data.init(contentsOf: newURL)
    }
    catch {
        print(error)
        UIApplication.shared.alert(body: "An unexpected error occurred.")
        return nil
    }
    let encoded:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
    // Return base64
    return encoded
}
