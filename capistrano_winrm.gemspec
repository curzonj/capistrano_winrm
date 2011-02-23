Gem::Specification.new do |gem|
  gem.name = "capistrano_winrm"
  gem.version = File.open('VERSION').readline.chomp
  gem.platform = Gem::Platform::RUBY
  gem.rubyforge_project  = nil

  gem.author = "Dan Wanek"
  gem.email = "dan.wanek@gmail.com"
  gem.homepage = "https://github.com/zenchild/capistrano_winrm"

  gem.summary = 'WinRM extensions for Capistrano'
  gem.description       = <<-EOF
    WinRM extensions for Capistrano
  EOF

  gem.files = `git ls-files`.split(/\n/)
  gem.require_path = "lib"
  gem.rdoc_options      = %w(-x test/ -x examples/)
  gem.extra_rdoc_files = %w(README)

  gem.required_ruby_version     = '>= 1.8.7'
  gem.add_runtime_dependency  'winrm'
  gem.add_runtime_dependency  'capistrano'
end
