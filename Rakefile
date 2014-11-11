require 'highline/import'

def working_dir
  File.dirname(__FILE__)
end

def images_dir(slug)
  File.join('assets', 'article_images', slug)
end

desc 'Create a new post'
task :post do
  title = ENV['TITLE'] || ask('Title of the post: ')
  slug = "#{Date.today}-#{title.downcase.gsub(/[^\w]+/, '-')}"

  Dir.mkdir(File.join(working_dir, images_dir(slug)))

  file = File.join(
    File.dirname(__FILE__),
    '_posts',
    slug + '.markdown'
  )

  File.open(file, 'w') do |f|
    f << <<-EOS.gsub(/^    /, '')
---
layout: post
title: #{title}
published: false
categories:
tags:
# image: /#{images_dir(slug)}
# image_credit:
---

    EOS
  end

  system("#{ENV['EDITOR']} #{file}")
end
