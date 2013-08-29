Pod::Spec.new do |s|
  s.name         = "UIAlertView+Blocks"
  s.version      = "0.0.1"
  s.summary      = "Category on UIAlertView to use inline block callbacks instead of delegate callbacks."

  s.description  = <<-DESC
                   UIAlertView was created in a time before blocks, ARC, and judging by it’s naming - touch screens. Who “clicks” on an alert view anyway?
                   
                   Lets modernize this shizzle with some blocks goodness.
                   
                   DESC
                   
  s.homepage     = "https://github.com/ryanmaxwell/UIAlertViewBlocks"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Ryan Maxwell" => "ryanm@xwell.co.nz" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/ryanmaxwell/UIAlertViewBlocks.git", :tag => "0.0.1" }
  s.source_files  = '*.{h,m}'
end