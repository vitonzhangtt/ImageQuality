# ImageQuality
Quality of JPEG image.
* The second parameter of UIImageJPEGRepresentation(UIImage * __nonnull image, CGFloat compressionQuality) method
is not the quality of the JPEG file which is create by saving the return value of this method.

The relationship between 'compressionQuality' and 'jpeg's quality'.

 compressionQuality | jpeg's quality 
 --- | --- 
 0.9  | 96
 0.7  | 91 
 0.6  | 86 
 0.5  | 78 
 0.45 | 72 

The jpeg's quality is acquired by the command ling `identify -verbose filename.jpeg` .

