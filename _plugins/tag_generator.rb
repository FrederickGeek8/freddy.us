Jekyll::Hooks.register :posts, :pre_render do |post|
    all_existing_tags = Dir.entries("blog/tags")
    .map { |t| t.match(/(.*).md/) }
    .compact.map { |m| m[1] }

    tags = post['tags'].reject { |t| t.empty? }
    tags.each do |tag|
    generate_tag_file(tag) if !all_existing_tags.include?(tag)
    end
end

def generate_tag_file(tag)
    # generate tag file
    File.open("blog/tags/#{tag}.md", "wb") do |file|
    file << "---\nlayout: tagpage\ntag: #{tag}\n---\n"
    end
end
