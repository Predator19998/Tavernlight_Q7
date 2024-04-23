# Try to find the VORBISFILE library
#  VORBISFILE_FOUND - system has VORBISFILE
#  VORBISFILE_INCLUDE_DIR - the VORBISFILE include directory
#  VORBISFILE_LIBRARY - the VORBISFILE library

FIND_PATH(VORBISFILE_INCLUDE_DIR NAMES vorbis/vorbisfile.h)
SET(_VORBISFILE_STATIC_LIBS libvorbisfile.a)
SET(_VORBISFILE_SHARED_LIBS libvorbisfile.dll.a vorbisfile)
IF(USE_STATIC_LIBS)
    FIND_LIBRARY(VORBISFILE_LIBRARY NAMES ${_VORBISFILE_STATIC_LIBS} ${_VORBISFILE_SHARED_LIBS})
ELSE()
    FIND_LIBRARY(VORBISFILE_LIBRARY NAMES ${_VORBISFILE_SHARED_LIBS} ${_VORBISFILE_STATIC_LIBS})
ENDIF()
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(VorbisFile DEFAULT_MSG VORBISFILE_LIBRARY VORBISFILE_INCLUDE_DIR)
MARK_AS_ADVANCED(VORBISFILE_LIBRARY VORBISFILE_INCLUDE_DIR)
