path = "../../fooberry-blog/articles/*.txt"
files = Dir.glob path
files.each do |f|
  old_post = File.read f
  file = File.basename(f)[0..-5]
  title = old_post.match(/title:\s+([^\n]+)/)
  title = title ? title [1] : ""
  File.open("../_posts/#{file}.md", "w") do |new_file|
    new_file.puts "---"
    new_file.puts "title: #{title}"
    new_file.puts "layout: post"
    new_file.puts "description: \"Something really cool\""
    new_file.puts "category:"
    new_file.puts "tags: [ ] "
    new_file.puts "---"
    new_file.puts "{% include JB/setup %}"
    new_file.puts old_post.split(/\n/)[3..-1].join("\n")


  end

end
