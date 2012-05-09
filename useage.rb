require 'file_copy_task'

# Now use it!

# load in a hash from a yaml
file_copy_task_hash = YAML::load( File.open('file_copy_task.yml') 
  # => { :source_directory => 'copy_from_dir', :destination_directory => 'copy_to_dir', :file_extension => '.txt' }

# Now lets make it a useable object
file_copy_task = FileCopyTask.new( file_copy_task )
 # => hash keys have now been loaded as attribute accessors. huzzah. use 'em...

file_copy_task.source_directory
  # => 'copy_from_dir'

file_copy_task.destination_directory = 'hey_look_a_new_destination_directory'
  # => 'hey_look_a_new_destination_directory'

File.cp( file_copy_task.source_directory + file_copy_task.find_a_source_file,   file_copy_task.destination_directory )