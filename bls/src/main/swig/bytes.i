/* -----------------------------------------------------------------------------
 * bytes.i
 *
 * Typemaps for bls::Bytes and const bls::Bytes&
 * These are mapped to a Java String and are passed around by value.
 *
 * To use non-const std::Bytes references use the following %apply.  Note
 * that they are passed by value.
 * %apply const std::Bytes & {std::Bytes &};
 * ----------------------------------------------------------------------------- */

%{
#include "bls-signatures/include/dashbls/util.hpp"
%}

namespace bls {

%naturalvar Bytes;

class Bytes;

%feature("valuewrapper") Bytes;

// Bytes
%typemap(jni) Bytes "jbyteArray"
%typemap(jtype) Bytes "byte[]"
%typemap(jstype) Bytes "byte[]"


%typemap(in) Bytes
%{
    Bytes $1_bytesObject((const uint8_t *)jenv->GetByteArrayElements($input, 0), jenv->GetArrayLength($input));
    $1 = $1_bytesObject;
%}

%typemap(argout) Bytes {
    JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *) $1.begin(), 0);
}

%typemap(out) Bytes {
    $result = JCALL1(NewByteArray, jenv, $1.size());
   JCALL4(SetByteArrayRegion, jenv, $result, 0, $1.size(), (jbyte *) $1.begin());
}

%typemap(javain) Bytes "$javainput"

%typemap(javaout) Bytes {
    return $jnicall;
  }

%typemap(typecheck) Bytes = char *;

%typemap(throws) Bytes
%{ SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "null Bytes");
   return $null; %}

// const Bytes &
%typemap(jni) const Bytes & "jbyteArray"
%typemap(jtype) const Bytes & "byte[]"
%typemap(jstype) const Bytes & "byte[]"

%typemap(in) const Bytes &
%{
    Bytes $1_bytesObject((const uint8_t *)jenv->GetByteArrayElements($input, 0), jenv->GetArrayLength($input));
    $1 = &$1_bytesObject;
%}
%typemap(argout) const Bytes & {
    JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *) $1->begin(), 0);
}

%typemap(out) const Bytes & {
   $result = JCALL1(NewByteArray, jenv, (*$1).size());
   JCALL4(SetByteArrayRegion, jenv, $result, 0, (*$1).size(), (jbyte *) $1->begin());
}

%typemap(javain) const Bytes & "$javainput"

%typemap(javaout) const Bytes & {
    return $jnicall;
  }

%typemap(typecheck) const Bytes & = char *;

%typemap(throws) const Bytes &
%{ SWIG_JavaThrowException(jenv, SWIG_JavaRuntimeException, "null Bytes");
   return $null; %}

}