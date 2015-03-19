# coding: utf-8
$:.unshift File.expand_path("../lib", __FILE__)
require 'vagrant-fabric/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-fabric"
  spec.version       = VagrantPlugins::Fabric::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Takahiro Fujiwara"]
  spec.email         = ["email@wuta.li"]
  spec.homepage      = "https://github.com/wutali/vagrant-fabric"
  spec.description   = "Enables Vagrant to provision with python fabric script."
  spec.summary       = "Enables Vagrant to provision with python fabric script."
  spec.license       = "MIT"

  spec.required_rubygems_version = ">= 1.3.6"
  spec.rubyforge_project = "vagrant-fabric"

  spec.add_development_dependency "bundler", "< 1.8"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.12"
  spec.add_development_dependency "rspec-its"


  # The following block of code determines the files that should be included
  # in the gem. It does this by reading all the files in the directory where
  # this gemspec is, and parsing out the ignored files from the gitignore.
  # Note that the entire gitignore(5) syntax is not supported, specifically
  # the "!" syntax, but it should mostly work correctly.
  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    # Ignore any paths that match anything in the gitignore. We do
    # two tests here:
    #
    #   - First, test to see if the entire path matches the gitignore.
    #   - Second, match if the basename does, this makes it so that things
    #     like '.DS_Store' will match sub-directories too (same behavior
    #     as git).
    #
    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end

  spec.files         = unignored_files
  spec.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  spec.require_path  = 'lib'
end
