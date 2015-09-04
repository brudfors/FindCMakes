#Find MKL Path
#BY SAMIRA SOJOUDI 
  
  
SET(MKL_INCLUDE_DIR "H:/bin/Intel MKL/mkl/include" CACHE INTERNAL "" FORCE ) 
SET(MKL_LIB_DIR_PREFIX "H:/bin/Intel MKL" CACHE INTERNAL "" FORCE) 
SET(MKL_DLL_DIR_PREFIX "H:/bin/Intel MKL/redist" CACHE INTERNAL "" FORCE) 

get_property(LIB64 GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS) 

message("The size of void P:")
message(${CMAKE_SIZEOF_VOID_P})

IF(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
	MESSAGE("64 Bit windows")		
	#Finding LIB Path
	FIND_PATH(MKL_LIB_DIR 
		  mkl_intel_ilp64_dll.lib mkl_intel_lp64_dll.lib;mkl_intel_thread_dll.lib;mkl_core_dll.lib,mkl_intel_ilp64.lib			
		  ${MKL_LIB_DIR_PREFIX}/mkl/lib/intel64
		  )		  
		  
	IF (${MKL_LIB_DIR} STREQUAL "" OR ${MKL_LIB_DIR} STREQUAL "MKL_LIB_DIR-NOTFOUND")
	   SET (MKL_LIB_DIR "MKL_LIB_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL root directory first!")
	ENDIF (${MKL_LIB_DIR} STREQUAL "" OR ${MKL_LIB_DIR} STREQUAL "MKL_LIB_DIR-NOTFOUND")

	FIND_PATH(MKL_COMP_DIR 
		  libiomp5md.lib			
		  ${MKL_LIB_DIR_PREFIX}/compiler/lib/intel64
		  )		  
		  
	IF (${MKL_COMP_DIR} STREQUAL "" OR ${MKL_COMP_DIR} STREQUAL "MKL_COMP_DIR-NOTFOUND")
	   SET (MKL_COMP_DIR "MKL_COMP_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL lib compiler directory first!")
	ENDIF (${MKL_COMP_DIR} STREQUAL "" OR ${MKL_COMP_DIR} STREQUAL "MKL_COMP_DIR-NOTFOUND")
	
	#Finding DLL Path
	FIND_PATH(MKL_DLL_DIR 
		  mkl_core.dll			
		  ${MKL_DLL_DIR_PREFIX}/intel64/mkl
		  )		
		  
	IF (${MKL_DLL_DIR} STREQUAL "" OR ${MKL_DLL_DIR} STREQUAL "MKL_DLL_DIR-NOTFOUND")
	   SET (MKL_DLL_DIR "MKL_DLL_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL dll directory first!")
	ENDIF (${MKL_DLL_DIR} STREQUAL "" OR ${MKL_DLL_DIR} STREQUAL "MKL_DLL_DIR-NOTFOUND")

	SET(MKL_LIBRARIES
		mkl_intel_lp64_dll.lib
		mkl_intel_thread_dll.lib
		mkl_core_dll.lib
		libiomp5md.lib
		#mkl_intel_ilp64;mkl_core;mkl_intel_ilp64_dll;
		#mkl_intel_lp64_dll;mkl_intel_thread_dll;mkl_core_dll;libiomp5md
		)
		
	LINK_DIRECTORIES(${MKL_LIB_DIR} ${MKL_COMP_DIR} ${MKL_DLL_DIR})		
	#SET (MKL_DLL ${MKL_DLL_DIR}/mkl_core.dll)
	
	
ELSE(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
	MESSAGE("32 Bit windows")		
	
	FIND_PATH(MKL_LIB_DIR 
		 mkl_intel_thread.lib;mkl_core.lib;
		 mkl_intel_c_dll.lib;mkl_intel_thread_dll.lib;
		 mkl_core_dll.lib
		  ${MKL_LIB_DIR_PREFIX}/mkl/lib/ia32
		  )		  
		  
	IF (${MKL_LIB_DIR} STREQUAL "" OR ${MKL_LIB_DIR} STREQUAL "MKL_LIB_DIR-NOTFOUND")
	   SET (MKL_LIB_DIR "MKL_LIB_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL root directory first!")
	ENDIF (${MKL_LIB_DIR} STREQUAL "" OR ${MKL_LIB_DIR} STREQUAL "MKL_LIB_DIR-NOTFOUND")

	FIND_PATH(MKL_COMP_DIR 
		  libiomp5md.lib			
		  ${MKL_DIR_TMP}/compiler/lib/ia32
		  )		  
		  
	IF (${MKL_COMP_DIR} STREQUAL "" OR ${MKL_COMP_DIR} STREQUAL "MKL_COMP_DIR-NOTFOUND")
	   SET (MKL_COMP_DIR "MKL_COMP_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL lib compiler directory first!")
	ENDIF (${MKL_COMP_DIR} STREQUAL "" OR ${MKL_COMP_DIR} STREQUAL "MKL_COMP_DIR-NOTFOUND")
	
	#Finding DLL Path
	FIND_PATH(MKL_DLL_DIR 
		  mkl_core.dll			
		  ${MKL_DLL_DIR_PREFIX}/ia32/mkl
		  )		
	Message (${MKL_DLL_DIR})		
		  
	IF (${MKL_DLL_DIR} STREQUAL "" OR ${MKL_DLL_DIR} STREQUAL "MKL_DLL_DIR-NOTFOUND")
	   SET (MKL_DLL_DIR "MKL_DLL_DIR-NOTFOUND" CACHE PATH "" FORCE)
	   MESSAGE(FATAL_ERROR "Please select MKL dll directory first!")
	ENDIF (${MKL_DLL_DIR} STREQUAL "" OR ${MKL_DLL_DIR} STREQUAL "MKL_DLL_DIR-NOTFOUND")
	
	SET(MKL_LIBRARIES
		mkl_intel_thread;mkl_core;
		mkl_intel_c_dll;mkl_intel_thread_dll;
		mkl_core_dll;libiomp5md)
		
	LINK_DIRECTORIES(${MKL_LIB_DIR} ${MKL_COMP_DIR}
				     ${MKL_DLL_DIR})
		
ENDIF(${CMAKE_SIZEOF_VOID_P} EQUAL 8)
 
				 
INCLUDE_DIRECTORIES(${MKL_INCLUDE_DIR} )	

FIND_PATH(MKL_INCLUDES 
		  mkl.h			
		  ${MKL_INCLUDE_DIR}
	)
ADD_DEFINITIONS(-IDE_VERSION="MKL_11_1_11.1.5000.103_EM64T")  
message ("Processor definition is set")

#-----------------------------------------------------------------------------
# Installation rules for use with Slicer extensions
if (Slicer_INSTALL_QTLOADABLEMODULES_LIB_DIR)
 install(DIRECTORY ${MKL_DLL_DIR}/ DESTINATION ${Slicer_INSTALL_QTLOADABLEMODULES_LIB_DIR}
          FILES_MATCHING PATTERN "*.dll")
endif (Slicer_INSTALL_QTLOADABLEMODULES_LIB_DIR)