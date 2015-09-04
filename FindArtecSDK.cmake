# - Try to find Artec 3D Scanning SDK
# Once done this will define
#  ARTECSDK_FOUND - System has the ArtecS DK
#  ARTECSDK_INCLUDE_DIRS - The Artec SDK include directories
#  ARTECSDK_LIBRARIES - The libraries needed to use Artec SDK
# By: Mikael Brudfors (brudfors[snabel-a]gmail.com)

# A dummy variable in order to let the user specify the root 
# directory of the ARTEC SDK (.../Artec 3D Scanning SDK)
find_path(ARTECSDK_ROOT 
          NAMES dummy)
  
if(ARTECSDK_ROOT)
  # Set include directories
  find_path(ARTECSDK_ALGORITHM_INCLUDE_DIR 
            NAMES Algorithms.h
            PATHS ${ARTECSDK_ROOT}
            PATH_SUFFIXES "/algorithm-sdk/include"
            DOC "algorithm-sdk include directory"
            NO_DEFAULT_PATH)

  find_path(ARTECSDK_BASE_INCLUDE_DIR 
            NAMES IImage.h
            PATHS ${ARTECSDK_ROOT}
            PATH_SUFFIXES "/base-sdk/include"
            DOC "base-sdk include directory"
            NO_DEFAULT_PATH)

  find_path(ARTECSDK_IO_INCLUDE_DIR 
            NAMES ImageIO.h
            PATHS ${ARTECSDK_ROOT}
            PATH_SUFFIXES "/base-sdk/include/IO"
            DOC "IO include directory"
            NO_DEFAULT_PATH)

  find_path(ARTECSDK_CAPTURE_INCLUDE_DIR 
            NAMES IFrame.h
            PATHS ${ARTECSDK_ROOT}
            PATH_SUFFIXES "/capture-sdk/include"
            DOC "capture-sdk include directory"
            NO_DEFAULT_PATH)

  find_path(ARTECSDK_SCANNING_INCLUDE_DIR 
            NAMES IScanningProcedure.h
            PATHS ${ARTECSDK_ROOT}
            PATH_SUFFIXES "/scanning-sdk/include" 
            DOC "scanning-sdk include directory"
            NO_DEFAULT_PATH)

  # Set library locations depending on 32 or 64-bit Windows		  
  if(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
    # 64-bit Windows
    find_library(ARTECSDK_ALGORITHM_LIBRARY 
                 NAMES algorithm-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "algorithm-sdk/bin-x64"
                 DOC "algorithm-sdk library")
    find_library(ARTECSDK_BASE_LIBRARY 
                 NAMES base-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "base-sdk/bin-x64"
                 DOC "base-sdk library")
    find_library(ARTECSDK_CAPTURE_LIBRARY 
                 NAMES capture-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "capture-sdk/bin-x64"
                 DOC "capture-sdk library")
    find_library(ARTECSDK_SCANNING_LIBRARY 
                 NAMES scanning-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "scanning-sdk/bin-x64"
                 DOC "scanning-sdk library")				 
  else(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
    # 32-bit Windows
    find_library(ARTECSDK_ALGORITHM_LIBRARY 
                 NAMES algorithm-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "algorithm-sdk/bin"
                 DOC "algorithm-sdk library")
    find_library(ARTECSDK_BASE_LIBRARY 
                 NAMES base-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "base-sdk/bin"
                 DOC "base-sdk library")
    find_library(ARTECSDK_CAPTURE_LIBRARY 
                 NAMES capture-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "capture-sdk/bin"
                 DOC "capture-sdk library")
    find_library(ARTECSDK_SCANNING_LIBRARY 
                 NAMES scanning-sdk
                 PATHS ${ARTECSDK_ROOT}
                 PATH_SUFFIXES "scanning-sdk/bin"
                 DOC "scanning-sdk library")	
  endif(${CMAKE_SIZEOF_VOID_P} EQUAL 8)

  set(ARTECSDK_LIBRARIES 
      ${ARTECSDK_ALGORITHM_LIBRARY}
      ${ARTECSDK_BASE_LIBRARY}
      ${ARTECSDK_CAPTURE_LIBRARY}
      ${ARTECSDK_SCANNING_LIBRARY})

  set(ARTECSDK_INCLUDE_DIRS
      ${ARTECSDK_ROOT})
      #${ARTECSDK_ALGORITHM_INCLUDE_DIR}
      #${ARTECSDK_BASE_INCLUDE_DIR}
      #${ARTECSDK_IO_INCLUDE_DIR}
      #${ARTECSDK_CAPTURE_INCLUDE_DIR}
      #${ARTECSDK_SCANNING_INCLUDE_DIR})

  # Just for convenience...	  
  set(ALL_LIBARIES
      ARTECSDK_ALGORITHM_LIBRARY ARTECSDK_BASE_LIBRARY  ARTECSDK_CAPTURE_LIBRARY ARTECSDK_SCANNING_LIBRARY)

  set(ALL_INCLUDE_DIRECTORIES
      ARTECSDK_ALGORITHM_INCLUDE_DIR ARTECSDK_BASE_INCLUDE_DIR ARTECSDK_IO_INCLUDE_DIR
      ARTECSDK_CAPTURE_INCLUDE_DIR ARTECSDK_SCANNING_INCLUDE_DIR)
	  
  include(FindPackageHandleStandardArgs)
  # handle the QUIETLY and REQUIRED arguments and set ARTECSDK_FOUND to TRUE
  # if all listed variables are TRUE
  find_package_handle_standard_args(ArctedSDK  DEFAULT_MSG
                                    ALL_LIBARIES ALL_INCLUDE_DIRECTORIES)
									  
  foreach(i ${ALL_LIBARIES} ${ALL_INCLUDE_DIRECTORIES})
    mark_as_advanced(${i})
  endforeach(i)	
  
else(ARTECSDK_ROOT)
  message(FATAL_ERROR "Set ARTECSDK_ROOT!")

endif (ARTECSDK_ROOT)