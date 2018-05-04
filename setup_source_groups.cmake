macro(setup_source_groups SourceFileList ProjectRootDir)
  get_filename_component(ProjectRootDir "${ProjectRootDir}" ABSOLUTE)
  string(REPLACE "\\" "/" ProjectRootDir "${ProjectRootDir}")

  string(FIND "${ProjectRootDir}" ".." contains_dotdot)
  if ("${contains_dotdot}" GREATER -1)
    message(FATAL_ERROR " ProjectRootDir must not contains '..'.  Use 'get_filename_component(<VAR> <FileName> DIRECTORY)' to get parent directory.")
  endif()

  foreach(source_file_path ${SourceFileList})
    get_filename_component(source_file_path "${source_file_path}" ABSOLUTE)
    string(REPLACE "\\" "/" source_file_path "${source_file_path}")

    string(REGEX REPLACE "^${ProjectRootDir}/" "" relative_path "${source_file_path}")

    get_filename_component(dirname "${relative_path}" DIRECTORY)

    string(REPLACE "/" "\\" group_name "${dirname}")
    source_group("${group_name}" FILES "${source_file_path}")
  endforeach()
endmacro()
