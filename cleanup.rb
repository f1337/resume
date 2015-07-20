require 'jekyll'
require 'yaml'
require 'pry'

site = Jekyll::Site.new(Jekyll::Configuration::DEFAULTS)
site.read

binding.pry

site.posts.each do |post|
	# 1. read every .html file in _posts (site.posts? filter how?)
	# 2. parse the yaml and the content (post.data & post.content?)
	# D. strip <p> and <br /> tags (/<(br \/|\/?p)>/)
	# E. strip :meta and :author from post.data
	# F. concatenate post.data and post.content. don't forget yaml delimeters.
	# G. save the file under year/filename.md
end
