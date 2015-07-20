require 'jekyll'
require 'yaml'
require 'pry'

site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
site.read


site.posts.each do |post|
	# 1. read every .html file in _posts (site.posts? filter how?)
	if post.path =~ /_posts\/(\d+)\-\d+\-\d+\-[^\.]+\.html/
		year = $~[1]
		dir = "_posts/#{year}"
		filename = post.path.sub('_posts/', "#{dir}/").sub('.html', '.md')
		# 2. parse the yaml and the content (post.data & post.content?)
		# D. strip <p> and <br /> tags (/<(br \/|\/?p)>/)
		post.content.gsub!(/<(br \/|\/?p)>/, '')
		# E. strip :meta and :author from post.data
		post.data.delete('meta')
		post.data.delete('author')
		# F. concatenate post.data and post.content. don't forget yaml delimeters.
		output = post.data.to_yaml << "---\n" << post.content
		# G. save the file under year/filename.md
		Dir.mkdir(dir) unless Dir.exist?(dir)
		File.write(filename, output)
	end
end
