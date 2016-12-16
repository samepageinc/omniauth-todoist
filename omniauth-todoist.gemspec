Gem::Specification.new do |gem|
  gem.name    = 'omniauth-todoist'
  gem.version = '0.1'
  gem.date    = Date.today.to_s
  gem.license = 'MIT'
  gem.summary = "OmniAuth strategy for Todoist"
  gem.description = "OmniAuth strategy for Todoist"

  gem.authors  = ['Bethany Soule']
  gem.email    = 'bsoule@beeminder.com'
  gem.homepage = 'https://github.com/beeminder/omniauth-todoist'

  gem.files = `git ls-files`.split("\n") 
  gem.require_path = 'lib'
end
