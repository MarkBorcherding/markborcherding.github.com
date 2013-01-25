# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'jekyll' do
  watch /^(_posts|_includes|_layouts)/
  watch /^css/
  watch /^js/
  watch /^images/
end


guard 'compass' do
  watch /^sass\/(.*)\.s[ac]ss/
end


guard 'livereload', :requre => 'zurb-foundation' do
  watch /^_site\/.+\.(css|js|html)/
end
