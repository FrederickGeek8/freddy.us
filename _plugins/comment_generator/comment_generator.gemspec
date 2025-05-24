Gem::Specification.new do |spec|
  spec.name = "comment_generator"
  spec.version = '0.0.1'
  spec.author = "Frederick Morlock"
  spec.required_ruby_version = ">= 3.1.0"

  spec.summary = "Comment generator system for Jekyll based off of a backing sqlite3 database."

  spec.add_dependency "sqlite3", "~> 2.2"
  spec.files = ["lib/comment_generator.rb"]
end
