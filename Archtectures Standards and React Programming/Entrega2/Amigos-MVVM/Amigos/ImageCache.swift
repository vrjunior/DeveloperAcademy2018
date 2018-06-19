//
//  ImageCache.swift
//  Amigos
//
//  Created by Marcelo Reina on 16/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation
import UIKit

/// Singleton responsible for download and cache images based on their url
class ImageCache {
    
    /// shared instance
    static var shared: ImageCache = ImageCache()
    
    /// dictionary to store UIImages on memory. URL is the key, UIImage is the value
    fileprivate var memoryCache: [URL: UIImage] = [URL: UIImage]()
    
    /// operation queue that performs all donwload operations outside the main queue
    fileprivate var downloadQueue: OperationQueue = OperationQueue()
    
    /// stores ongoing operations to provide the option to cancel the download
    fileprivate var downloadOperationOngoing: [URL: Operation] = [URL: Operation]()
    
    /// private init to force the use of shared instance
    fileprivate init() {}
    
    /// remove all cached data
    func clear() {
        memoryCache.removeAll()
        downloadOperationOngoing.removeAll()
    }
    
    /// Get image from memeory and calls 'completion' handler. If the image is not cached yet, it downloads the data from the 'url', store in the memory cache and calls the completion handler.
    /// - Note: The operation is performed outside the main thread but the completion handler is called from main thread.
    ///
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: closure that receives the cached or downloaded image in a succeeded situation. If anything goes wrong, 'nil' is passed to 'completion'.
    func getImage(from url:URL, completion: @escaping (UIImage?) -> ()) {
        // check if the image is already cached
        if let imageFromCache = memoryCache[url] {
            // image loaded from cache
            completion(imageFromCache)
        } else {
            // time to download the image. It will be performed in a operation queue, out of the main thread in order to avoid locking the user interface. The completion handler is always called from the main operation queue.
            let operation = BlockOperation(block: { 
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.memoryCache[url] = image
                        OperationQueue.main.addOperation {
                            // before returning the image, check if a cancel request was made.
                            // If it was, just call completion with nil.
                            if let op = self.downloadOperationOngoing[url] {
                                if op.isCancelled {
                                    print("Canceled!!")
                                    completion(nil)
                                } else {
                                    completion(image)
                                }
                            } else {
                                completion(image)
                            }
                        }
                        
                    } else {
                        OperationQueue.main.addOperation {
                            completion(nil)
                        }
                    }
                } else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                }
                
                //after all, remove the operation from ongoing
                OperationQueue.main.addOperation {
                    self.downloadOperationOngoing[url] = nil
                }
            })
            downloadOperationOngoing[url] = operation
            downloadQueue.addOperation(operation)
        }
    }
    
    
    /// If a download operation is in the queue, it will be marked as canceled.
    /// - Important: This action does not cancel a current download, it
    /// just makes the completion handler of a `getImage` execution to return nil
    /// instead of the download image.
    ///
    /// - Parameter url: URL to be canceled
    func cancelImageDownload(from url: URL) {
        if let operation = downloadOperationOngoing[url] {
            operation.cancel()
        }
    }
    
}
