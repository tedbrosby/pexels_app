# pexels_app

## Build instructions:  

Unfortunately I couldn't get the bundle exec pod install to work properly. I believe it's an issue with Ruby directory on M1 MacBooks.  
  
Please:  
- run `pod install` as normal 

Remaining work:  
- [x] Register API key from Pexels API  
- [x] Basic APIRequest data structure, protocol and loading mechanism  
- [x] ViewModel that loads images and API responses using Codable and Observable  
- [x] Collection View with custom cell to display image  
-  [x] Ensure the image isn't recycled by using an applyImage function  
- [ ] Tap image to display full screen image  
