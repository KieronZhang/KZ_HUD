
Pod::Spec.new do |s|

    s.name = 'KZ_HUD'
    s.version = '0.1'
    s.summary = 'iOS HUD.'
    s.homepage = 'https://github.com/KieronZhang/KZ_HUD'
    s.license = {:type => 'MIT', :file => 'LICENSE'}
    s.author = {'KieronZhang.' => 'https://github.com/KieronZhang'}
    s.platform = :ios, '8.0'
    s.source = {:git => 'https://github.com/KieronZhang/KZ_HUD.git', :tag => s.version, :submodules => true}
    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
    s.frameworks = 'UIKit', 'Foundation'
    s.vendored_frameworks = 'KZ_HUD/KZ_HUDFramework.framework'
    s.requires_arc = true

    s.dependency 'KZ_JSON'
    s.dependency 'KZ_Categories'

end
