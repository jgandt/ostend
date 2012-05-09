require 'objectify_from_hash'

class FileCopyTask
  include ObjectifyFromHash

  def initialize( file_copy_task_as_hash )
    objectify file_copy_task_as_hash
  end

  # My implementation implements a method similar to this one. This is just a quick example
  def find_a_source_file
    # find a file in source dir with the proper file extension.
  end
end