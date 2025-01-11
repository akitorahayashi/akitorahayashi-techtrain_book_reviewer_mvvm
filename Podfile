platform :ios, '15.0'

target 'techtrain_book_reviewer_mvvm' do
  # Use dynamic frameworks (recommended for Firebase)
  use_frameworks!

  # Alamofire for main target
  pod 'Alamofire', '~> 5.6'

  # Unit test target
  target 'techtrain_book_reviewer_mvvmTests' do
    inherit! :search_paths

    # Include Alamofire for testing
    pod 'Alamofire', '~> 5.6'
  end

  # UI test target
  target 'techtrain_book_reviewer_mvvmUITests' do
    inherit! :search_paths
    # Add pods for UI testing, if needed
  end
end

